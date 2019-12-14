import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String _uid;
  String _phoneNumber;
  String _userName;
  Map<String, dynamic> _avgSongScores;
  Map<String, num> _listenHistory;

  String get uid => _uid;
  String get phoneNumber => _phoneNumber;
  String get userName => _userName;
  Map<String, dynamic> get avgSongScores => _avgSongScores;
  Map<String, num> get listenHistory => _listenHistory;

  Profile addSongToHistory(String songName) {
    String formattedSongName = songName.trim();
    if (formattedSongName.contains("-")) {
      formattedSongName = formattedSongName.split("-")[1];
    }

    if (formattedSongName.contains("'")) {
      formattedSongName = formattedSongName.replaceAll("'", "");
    }

    if (formattedSongName.contains("\"")) {
      formattedSongName = formattedSongName.replaceAll("\"", "");
    }
    if (_listenHistory[formattedSongName] == null) {
      this._listenHistory[formattedSongName] = 1;
    } else {
      this._listenHistory[formattedSongName]++;
    }
    return this;
  }

  Profile._({
    String uid,
    String phoneNumber,
    String userName,
    Map<String, dynamic> avgSongScores,
    Map<String, num> listenHistory,
  })  : _uid = uid,
        _phoneNumber = phoneNumber,
        _userName = userName,
        _avgSongScores = avgSongScores,
        _listenHistory = listenHistory;

  factory Profile.fromDocument(DocumentSnapshot doc) {
    if (doc == null) {
      return null;
    } else {
      Map<dynamic, dynamic> profileData = doc.data;
      return Profile._(
        uid: doc.documentID,
        phoneNumber: profileData['phoneNumber'],
        userName: profileData['name'],
        avgSongScores: Map.castFrom<dynamic, dynamic, String, dynamic>(
            profileData['averageScore']),
        listenHistory: Map.castFrom<dynamic, dynamic, String, num>(
            profileData['listenHistory']),
      );
    }
  }
}
