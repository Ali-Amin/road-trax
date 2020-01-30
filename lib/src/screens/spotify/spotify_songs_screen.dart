import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roadtrax/src/models/music.dart';

class SpotifySongScreen extends StatelessWidget {
  final Music _song;

  SpotifySongScreen({Music music}) : _song = music;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: FutureBuilder(
        future: _getSong(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text(
                "This song is not available on Spotify",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            );
          }
          final String _photoUrl = snapshot.data["album"]["images"][0]["url"];
          final String _albumName = snapshot.data["album"]["name"];
          final String _artistName = snapshot.data["artists"][0]["name"];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(_photoUrl), fit: BoxFit.fill),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fast_rewind),
                    iconSize: 50,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.play_circle_filled),
                    iconSize: 75,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fast_forward),
                    iconSize: 50,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Slider(
                  value: 0,
                  onChanged: (value) {},
                  activeColor: Color(0xFFF60068),
                  inactiveColor: Color(0xFFF60068).withOpacity(0.4),
                ),
              ),
              Divider(
                height: 50,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FittedBox(
                  child: Text(
                    _song.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FittedBox(
                  child: Text(
                    _artistName + ' - ' + _albumName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String> _getAccessToken() async {
    final _clientId = "81d88a7e42b04ae0acd2b97b5f3653ff";
    final _clientSecret = "0e713dfb66c24cb7b5965ea8ada161c7";
    String _auth = _clientId + ':' + _clientSecret;
    final _bytes = utf8.encode(_auth);
    final response = await http.post(
      "https://accounts.spotify.com/api/token",
      headers: {
        "Authorization": 'Basic ' + base64.encode((_bytes)),
      },
      body: {
        "grant_type": 'client_credentials',
      },
    );
    final data = json.decode(response.body);
    return data["access_token"];
  }

  Future _getSong() async {
    final String _token = await _getAccessToken();
    final String _songInfo = parseSongInfo();
    final response = await http.get(
      "https://api.spotify.com/v1/search?query=" +
          _songInfo +
          "&type=track&market=US&offset=0&limit=1",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
    );
    final data = json.decode(response.body);
    return data["tracks"]["items"][0];
  }

  String parseSongInfo() {
    final _name = _song.name.replaceAll(' ', '+');
    final _artists = _song.artist.replaceAll(';', '+').replaceAll(' ', '+');
    final _album = _song.album.replaceAll(' ', '+');
    return _name + '+' + _artists + '+' + _album;
  }
}
