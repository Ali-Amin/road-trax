import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:roadtrax/src/models/music.dart';
import 'package:rxdart/rxdart.dart';

class MapsScreenBloc {
  BehaviorSubject<List<Music>> _songs$;
  CollectionReference _firestoreRoadsCollection;

  BehaviorSubject<List<Music>> get songs$ => _songs$;

  MapsScreenBloc() {
    _songs$ = BehaviorSubject<List<Music>>();
    _firestoreRoadsCollection = Firestore.instance.collection("roads");
  }

  // void updateSongs(String address) async {
  //   if (address == null) address = "";
  //   QuerySnapshot _query = await _firestoreRoadsCollection
  //       .where("name", isEqualTo: address)
  //       .getDocuments();

  //   final List<List<String>> _songs = _query.documents.map((doc) {
  //     final Road _road = Road.fromDocument(doc);
  //     return _road.songs;
  //   }).toList();

  //   if (_songs.length == 0) {
  //     _pushSongsToStream([]);
  //   } else {
  //     _pushSongsToStream(_songs.first);
  //   }
  // }
  void updateSongs(String address) async {
    try {
      Map<dynamic, dynamic> res = await CloudFunctions.instance.call(
        functionName: "getRecommendations",
      );
      List<dynamic> resBody = res['body'];
      List<Music> songs = resBody.map((json) {
        Map<String, dynamic> songJson =
            Map.castFrom<dynamic, dynamic, String, dynamic>(json);
        return Music.fromJson(songJson);
      }).toList();

      _pushSongsToStream(songs);
    } on CloudFunctionsException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void _pushSongsToStream(List<Music> songs) {
    _songs$.add(songs);
  }

  void dispose() {
    _songs$.close();
  }
}
