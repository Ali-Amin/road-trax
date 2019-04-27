import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  signInWithPhonenumber({
    @required FirebaseAuth firebaseAuthInstance,
    @required String phoneNumber,
    @required Function(AuthException) onVerificationFailed,
    @required Function(FirebaseUser) onVerifictionCompleted,
    @required Function(String) onAutoRetrievalTimeout,
    @required Function(String, [int]) onCodeSent,
  }) {
    if (phoneNumber[0] == "1") {
      phoneNumber = "0" + phoneNumber;
    }
    return firebaseAuthInstance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      forceResendingToken: 1,
      verificationFailed: onVerificationFailed,
      verificationCompleted: onVerifictionCompleted,
      codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
      codeSent: onCodeSent,
      timeout: Duration(seconds: 30),
    );
  }
}
