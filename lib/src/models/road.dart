import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  String _name;
  Map<String, num> _songs;

  Road({@required String name, @required Map<String, num> songs})
      : _name = name,
        _songs = songs;

  factory Road.fromDocument(DocumentSnapshot doc) {
    return Road(
      name: doc["name"],
      songs: doc["songs"],
    );
  }
}
