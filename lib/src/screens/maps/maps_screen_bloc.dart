import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class MapsScreenBloc {
  BehaviorSubject<Map<String, num>> _songs$;
  CollectionReference _firestoreRoadsCollection;

  BehaviorSubject<Map<String, num>> get songs$ => _songs$;

  MapsScreenBloc() {
    _songs$ = BehaviorSubject<Map<String, num>>();
    _firestoreRoadsCollection = Firestore.instance.collection("roads");
  }

  void updateSongs(String address) async {
    if (address == null) address = "";
    QuerySnapshot _query = await _firestoreRoadsCollection
        .where("name", isEqualTo: address)
        .getDocuments();

    final List<Map<dynamic, dynamic>> _currentSongs =
        _query.documents.map((DocumentSnapshot doc) {
      final Road _currentRoad = Road.fromDocument(doc);
      return _currentRoad.songs;
    }).toList();
    _pushSongsToStream(_currentSongs);
  }

  void _pushSongsToStream(List<Map<dynamic, dynamic>> songs) {
    Map<String, num> _finalSongs = {};
    songs.forEach((song) {
      final Map<String, num> _temp = Map.from(song);
      _temp.forEach((key, value) {
        if (!_finalSongs.containsKey(key)) {
          _finalSongs[key] = value;
        } else {
          _finalSongs[key] += value;
        }
      });
    });
    _songs$.add(_finalSongs);
  }

  void dispose() {
    _songs$.close();
  }
}
