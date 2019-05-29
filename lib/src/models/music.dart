import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  String _uid;
  String _name;
  String _artist;
  String _album;
  num _count;
  List<String> _users;

  String get uid => _uid;
  String get name => _name;
  String get artist => _artist;
  String get album => _album;
  num get count => _count;
  List<String> get users => _users;

  Music._(
    this._uid,
    this._name,
    this._artist,
    this._album,
    this._count,
    this._users,
  );

  factory Music.fromDocument(DocumentSnapshot doc) {
    if (doc == null) {
      return null;
    } else {
      Map<dynamic, dynamic> musicData = doc.data;
      return Music._(
        doc.documentID,
        musicData["name"],
        musicData["artist"],
        musicData["album"],
        musicData["count"],
        List<String>.from(musicData["users"]),
      );
    }
  }
}
