import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  String _name;
  String _id;
  List<String> _songs;

  String get name => _name;
  String get id => _id;
  List<String> get songs => _songs;

  Road(
      {@required String name,
      @required List<String> songs,
      @required String id})
      : _name = name,
        _songs = songs,
        _id = id;

  factory Road.fromDocument(DocumentSnapshot doc) {
    final Map<dynamic, dynamic> _roadData = doc.data;
    return Road(
      id: doc.documentID,
      name: _roadData["name"],
      songs: List<String>.from(_roadData["songs"]),
    );
  }
}
