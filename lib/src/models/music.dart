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

  Music._({
    String uid,
    String name,
    String artist,
    String album,
    num count,
    List<String> users,
  })  : _uid = uid,
        _name = name,
        _artist = artist,
        _album = album,
        _count = count,
        _users = users;

  factory Music.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Music._(
      uid: json["uid"],
      name: json["name"],
      artist: json["artist"],
      album: json['artist'],
      count: 0,
      users: [],
    );
  }

  factory Music.fromDocument(DocumentSnapshot doc) {
    if (doc == null) {
      return null;
    } else {
      Map<dynamic, dynamic> musicData = doc.data;
      return Music._(
        uid: doc.documentID,
        name: musicData["name"],
        artist: musicData["artist"],
        album: musicData["album"],
        count: musicData["count"],
        users: List<String>.from(musicData["users"]),
      );
    }
  }
}
