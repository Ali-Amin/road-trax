import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadtrax/src/common/music_card.dart';

class LocalMusicScreen extends StatefulWidget {
  @override
  _LocalMusicScreenState createState() => _LocalMusicScreenState();
}

class _LocalMusicScreenState extends State<LocalMusicScreen> {
  MusicFinder _audioPlayer;
  List<Song> _songs = [];

  @override
  void initState() {
    _requestPermissions();
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = new MusicFinder();
    var _tempSongs;
    try {
      _tempSongs = await MusicFinder.allSongs();
      setState(() {
        _songs = List.from(_tempSongs);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _requestPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF121A27),
      child: ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (BuildContext context, int index) {
          return MusicCard(
            index: index + 1,
            songName: _songs[index].title,
            genre: _songs[index].album,
          );
        },
      ),
    );
  }
}
