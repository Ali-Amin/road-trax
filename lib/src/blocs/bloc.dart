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

  Observable<String> get phoneNumber$ => Observable(_phoneNumber$.stream);
  Observable<String> get smsCode$ => Observable(_smsCode$.stream);
  Observable<AuthState> get authState$ => Observable(_authState$.stream);
  Observable<Profile> get profile$ => Observable(_profile$.stream);
  Observable<AuthException> get authError$ => Observable(_authError$.stream);

  Function(String) get changePhoneNumber => _phoneNumber$.sink.add;
  Function(String) get changeSmsCode => _smsCode$.sink.add;
  Function(String) get changeUserName => _userName$.sink.add;

  void sendSmsCode() async {
    _authState$.sink.add(AuthState.PhoneLoginLoading);
    String phoneNumber = _phoneNumber$.value;
    authService.signInWithPhonenumber(
      firebaseAuthInstance: _firebaseAuth,
      phoneNumber: phoneNumber,
      onAutoRetrievalTimeout: (String verificationid) {
        _verificationid = verificationid;
      },
      onCodeSent: (String verificationId, [int forceResendingToken]) {
        _verificationid = verificationId;
        _authState$.sink.add(AuthState.SmsSent);
      },
      onVerificationFailed: (AuthException exception) {
        _authError$.sink.add(exception);
        _authState$.sink.add(AuthState.PhoneLoginError);
      },
      onVerifictionCompleted: (FirebaseUser firebaseUser) async {
        bool userExists = await _checkIfUserExists();
        if (userExists) {
          _authState$.sink.add(AuthState.Authenticated);
        } else {
          await _firestore
              .collection('users')
              .document(firebaseUser.uid)
              .setData(
            {
              'phoneNumber': _phoneNumber$.value,
            },
            merge: true,
          );
          _authState$.sink.add(AuthState.UserDoesNotExist);
        }
      },
    );
  }

  void verifySmsCode() {
    _authState$.sink.add(AuthState.SmsVerificationLoading);
    String smsCode = _smsCode$.value;
    try {
      authService.verifySmsCode(
        firebaseAuthInstance: _firebaseAuth,
        smsCode: smsCode,
        verificationId: _verificationid,
      );
    } catch (e) {
      _authState$.sink.add(AuthState.SmsVerificationError);
    }
  }

  void signUp() async {
    FirebaseUser firebaseUser = await _firebaseAuth.onAuthStateChanged.first;
    String userUid = firebaseUser.uid;
    String phoneNumber = firebaseUser.phoneNumber;
    String userName = _userName$.value;
    if (phoneNumber[0] == "1") {
      phoneNumber = "0" + phoneNumber;
    }
    await _firestore
        .collection('users')
        .document(userUid)
        .setData({'name': userName}, merge: true);

    _firestore
        .collection('users')
        .document(userUid)
        .snapshots()
        .listen((DocumentSnapshot doc) {
      return _profile$.sink.add(Profile.fromDocument(doc));
    });
    _authState$.sink.add(AuthState.Authenticated);
  }

  void resetAuthentication() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {}
    _authState$.sink.add(AuthState.Initial);
  }

  Future<bool> _checkIfUserExists() async {
    FirebaseUser firebaseUser = await _firebaseAuth.onAuthStateChanged.first;
    String userUid = firebaseUser.uid;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').document(userUid).get();
    Map<dynamic, dynamic> userData = userDoc.data;

    if (userDoc.exists && userData['name'] != null) {
      return true;
    } else {
      return false;
    }
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
