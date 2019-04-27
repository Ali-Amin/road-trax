import 'package:roadtrax/src/models/models.dart';
import 'package:roadtrax/src/services/fireauth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bloc {
  FirebaseAuth _firebaseAuth;
  Firestore _firestore;
  AuthenticationService authService;
  String _verificationid;

  BehaviorSubject<String> _phoneNumber$;
  BehaviorSubject<String> _smsCode$;
  BehaviorSubject<AuthState> _authState$;
  BehaviorSubject<AuthException> _authError$;
  BehaviorSubject<String> _userName$;
  BehaviorSubject<Profile> _profile$;

  Bloc() {
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = Firestore.instance;
    authService = AuthenticationService();

    _phoneNumber$ = BehaviorSubject<String>();
    _smsCode$ = BehaviorSubject<String>();
    _authState$ = BehaviorSubject<AuthState>();
    _authError$ = BehaviorSubject<AuthException>();
    _userName$ = BehaviorSubject<String>();
    _profile$ = BehaviorSubject<Profile>();

    _firebaseAuth.onAuthStateChanged.listen((FirebaseUser firebaseUser) {
      if (firebaseUser != null) {
        _checkIfUserExists().then((bool userExists) {
          if (userExists) {
            _firestore
                .collection('users')
                .document(firebaseUser.uid)
                .snapshots()
                .listen((DocumentSnapshot doc) {
              return _profile$.sink.add(Profile.fromDocument(doc));
            });
            _authState$.sink.add(AuthState.Authenticated);
          } else {
            _firestore.collection('users').document(firebaseUser.uid).setData({
              'phoneNumber': firebaseUser.phoneNumber,
            });
            _authState$.sink.add(AuthState.UserDoesNotExist);
          }
        });
      } else {
        _authState$.sink.add(AuthState.Initial);
      }
    });
  }

  void dispose() {
    _phoneNumber$.close();
    _smsCode$.close();
    _authState$.close();
    _authError$.close();
    _userName$.close();
    _profile$.close();
  }
}
