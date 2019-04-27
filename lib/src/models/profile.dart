import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String _uid;
  String _phoneNumber;
  String _userName;

  String get uid => _uid;
  String get phoneNumber => _phoneNumber;
  String get userName => _userName;

  Profile._(
    this._uid,
    this._phoneNumber,
    this._userName,
  );

  factory Profile.fromDocument(DocumentSnapshot doc) {
    if (doc == null) {
      return null;
    } else {
      Map<dynamic, dynamic> profileData = doc.data;
      return Profile._(
        doc.documentID,
        profileData['phoneNumber'],
        profileData['name'],
      );
    }
  }
}
