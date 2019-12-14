import 'package:roadtrax/src/models/music.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapSongsBloc {
  BehaviorSubject<List<Music>> _songs$;
  // List<String> _songList;
  Observable<List<Music>> get songs$ => _songs$;

  MapSongsBloc() {
    _songs$ = BehaviorSubject<List<Music>>();
    // _songList = songList;
    // getSongs();
  }

  // Future<void> getSongs() async {
  //   List<Music> _currentSongs = [];
  //   for (String songUid in _songList) {
  //     final doc =
  //         await Firestore.instance.collection("songs").document(songUid).get();
  //     final Music _song = Music.fromDocument(doc);
  //     _currentSongs.add(_song);
  //   }

  //   _currentSongs.sort((a, b) {
  //     return b.count.compareTo(a.count);
  //   });

  //   _songs$.sink.add(_currentSongs);
  // }

  void pushToSongsStream(List<Music> songs) {
    _songs$.sink.add(songs);
  }

  void dispose() {
    _songs$.close();
  }
}
