import 'package:flutter/material.dart';
import 'package:roadtrax/src/common/music_card.dart';

class MapSongsScreen extends StatelessWidget {
  Map<String, num> _songs;
  List<String> _songNames;
  List<String> _songGenres;
  List<num> _count;

  MapSongsScreen({@required Map<String, num> songs}) {
    _songs = songs;
    _songNames = [];
    _songGenres = [];
    _count = _songs.values.toList();
    final List<String> _songsHeader = _songs.keys.toList();
    _songsHeader.forEach(
      (String key) {
        final List<String> _temp = key.split(';');

        _songNames.add(_temp[0]);
        if (_temp.length < 2) {
          _songGenres.add(" ");
        } else {
          _songGenres.add(_temp[1]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Map Songs"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        itemCount: _songs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xFFFE0069),
              ),
            ),
            key: Key(index.toString()),
            child: MusicCard(
              index: index + 1,
              songName: _songNames[index],
              genre: _songGenres[index],
            ),
          );
        },
      ),
    );
  }
}
