import 'package:flute_music_player/flute_music_player.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:roadtrax/src/models/music.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocalMusicBloc {
  BehaviorSubject<MapEntry<String, String>> _currentSong$;
  Observable<MapEntry<String, String>> get currentSong$ => _currentSong$;

  LocalMusicBloc() {
    _currentSong$ = BehaviorSubject<MapEntry<String, String>>();
  }

  Future<void> pushCountToDatabase(
      Song song, Profile user, String address) async {
    user = user.addSongToHistory(song.title);

    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({"listenHistory": user.listenHistory});
    // final QuerySnapshot _temp = await Firestore.instance
    //     .collection("songs")
    //     .where("name", isEqualTo: song.title)
    //     .getDocuments();
    // final List<Music> _songs = _temp.documents.map(
    //   (DocumentSnapshot doc) {
    //     return Music.fromDocument(doc);
    //   },
    // ).toList();

    // if (_songs.length == 0) {
    //   final Map<String, dynamic> _newSong = {
    //     "album": song.album,
    //     "artist": song.artist,
    //     "count": 1,
    //     "name": song.title,
    //     "users": [user.uid],
    //   };
    //   final ref = await Firestore.instance.collection("songs").add(_newSong);
    //   await _pushSongToRoads(address, ref.documentID);
    //   return;
    // }

    // await _pushSongToRoads(address, _songs.first.uid);
    // for (Music currentSong in _songs) {
    //   final List<String> users = currentSong.users;
    //   if (users.contains(user.uid)) {
    //     return;
    //   }
  }

  // final List<String> _users = List<String>.from(_songs.first.users);
  // _users.add(user.uid);
  // final Map<String, dynamic> _data = {
  //   "count": _songs.first.count + 1,
  //   "users": _users,
  // };
  //   await Firestore.instance
  //       .collection("songs")
  //       .document(_songs.first.uid)
  //       .setData(_data, merge: true);
  // }

  // Future<void> _pushSongToRoads(String address, String songUid) async {
  //   final QuerySnapshot _temp = await Firestore.instance
  //       .collection("roads")
  //       .where("name", isEqualTo: address)
  //       .getDocuments();
  //   final List<Road> _roads = _temp.documents.map(
  //     (DocumentSnapshot doc) {
  //       return Road.fromDocument(doc);
  //     },
  //   ).toList();

  //   if (_roads.length == 0) {
  //     final Map<String, dynamic> _newRoad = {
  //       "name": address,
  //       "songs": [songUid],
  //     };
  //     await Firestore.instance.collection("roads").add(_newRoad);
  //     return;
  //   }

  //   for (Road currentRoad in _roads) {
  //     final List<String> users = currentRoad.songs;
  //     if (users.contains(songUid)) {
  //       return;
  //     }
  //   }

  //   final List<String> _users = List<String>.from(_roads.first.songs);
  //   _users.add(songUid);
  //   final Map<String, dynamic> _data = {
  //     "songs": _users,
  //   };
  //   await Firestore.instance
  //       .collection("roads")
  //       .document(_roads.first.id)
  //       .setData(_data, merge: true);
  // }

  void playCurrentSong(String name) {
    final MapEntry<String, String> _state = MapEntry(name, "playing");
    _currentSong$.sink.add(_state);
  }

  void pauseCurrentSong(String name) {
    final MapEntry<String, String> _state = MapEntry(name, "paused");
    _currentSong$.sink.add(_state);
  }

  void dispose() {
    _currentSong$.close();
  }
}
