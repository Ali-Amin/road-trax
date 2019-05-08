import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class MapsScreenBloc {
  BehaviorSubject<List<String>> _songs$;
  CollectionReference _firestoreRoadsCollection;

  BehaviorSubject<List<String>> get songs$ => _songs$;

  MapsScreenBloc() {
    _songs$ = BehaviorSubject<List<String>>();
    _firestoreRoadsCollection = Firestore.instance.collection("roads");
  }

  void updateSongs(String address) async {
    if (address == null) address = "";
    QuerySnapshot _query = await _firestoreRoadsCollection
        .where("name", isEqualTo: address)
        .getDocuments();

    final List<List<String>> _songs = _query.documents.map((doc) {
      final Road _road = Road.fromDocument(doc);
      return _road.songs;
    }).toList();

    if (_songs.length == 0) {
      _pushSongsToStream([]);
    } else {
      _pushSongsToStream(_songs.first);
    }
  }

  void _pushSongsToStream(List<String> songs) {
    _songs$.add(songs);
  }

  void dispose() {
    _songs$.close();
  }
}
