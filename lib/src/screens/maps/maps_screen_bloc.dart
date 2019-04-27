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

  void updateSongs(String address) {
    _firestoreRoadsCollection
        .where("name", isEqualTo: address)
        .snapshots()
        .forEach((QuerySnapshot query) {
      final List<Road> _roads = query.documents.map((DocumentSnapshot doc) {
        doc.data["songs"] = Map.from(doc.data["songs"]);
        return Road.fromDocument(doc);
      }).toList();

      final List<Map<dynamic, dynamic>> _songs = _roads.map((Road road) {
        return road.songs;
      }).toList();

      _pushSongsToStream(_songs);
    });
  }

  void _pushSongsToStream(List<Map<dynamic, dynamic>> songs) {
    Map<String, num> _finalSongs = {};
    songs.forEach((song) {
      final Map<String, num> _temp = Map.from(song);
      _finalSongs.addAll(_temp);
    });

    _songs$.add(_finalSongs);
  }

  void dispose() {
    _songs$.close();
  }
}
