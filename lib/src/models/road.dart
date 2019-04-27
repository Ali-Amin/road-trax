import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  String _name;
  String _id;
  Map<String, num> _songs;

  String get name => _name;
  String get id => _id;
  Map<String, num> get songs => _songs;

  Road(
      {@required String name,
      @required Map<String, num> songs,
      @required String id})
      : _name = name,
        _songs = songs,
        _id = id;

  factory Road.fromDocument(DocumentSnapshot doc) {
    final Map<dynamic, dynamic> _roadData = doc.data;
    return Road(
      id: doc.documentID,
      name: _roadData["name"],
      songs: _roadData["songs"],
    );
  }
}
