import 'package:roadtrax/src/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bloc {
  FirebaseAuth _firebaseAuth;
  Firestore _firestore;
  String _verificationid;

  BehaviorSubject<String> _phoneNumber$;
  BehaviorSubject<String> _smsCode$;
  BehaviorSubject<AuthState> _authState$;
  BehaviorSubject<AuthException> _authError$;
  BehaviorSubject<String> _userName$;
  BehaviorSubject<Profile> _profile$;

  Bloc() {}
}
