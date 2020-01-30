import 'package:flutter/material.dart';
import 'package:roadtrax/src/common/music_card.dart';
import 'package:roadtrax/src/models/music.dart';
import 'package:roadtrax/src/screens/maps/map_songs_bloc.dart';
import 'package:roadtrax/src/screens/spotify/spotify_songs_screen.dart';

class MapSongsScreen extends StatefulWidget {
  final List<Music> _songs;

  MapSongsScreen({@required List<Music> songs}) : _songs = songs;

  @override
  _MapSongsScreenState createState() => _MapSongsScreenState();
}

class _MapSongsScreenState extends State<MapSongsScreen> {
  MapSongsBloc _mapSongsBloc;

  @override
  void initState() {
    _mapSongsBloc = MapSongsBloc();
    super.initState();
  }

  @override
  void dispose() {
    _mapSongsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Music> _songs = widget._songs;

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
      body:
          // StreamBuilder<List<Music>>(
          // stream: _mapSongsBloc.songs$,
          // builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
          //   if (!snapshot.hasData) {
          //     return Center(
          //       child: CircularProgressIndicator(
          //         valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF60068)),
          //       ),
          //     );
          //   }
          // return
          RefreshIndicator(
        onRefresh: () {}, // _mapSongsBloc.getSongs(),
        color: Color(0xFFF60068),
        child: ListView.builder(
          itemCount: _songs.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                _songs.remove(_songs[index]);
                _mapSongsBloc.pushToSongsStream(_songs);
              },
              background: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xFFF60068),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpotifySongScreen(music: _songs[index]),
                      ));
                },
                child: MusicCard(
                  index: index + 1,
                  songName: _songs[index].name,
                  genre: _songs[index].album,
                  count: _songs[index].count,
                ),
              ),
            );
          },
        ),
      ),
      // },
      // ),
    );
  }
}
