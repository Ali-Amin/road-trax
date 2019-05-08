import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:geocoder/geocoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:roadtrax/src/blocs/bloc.dart';
import 'package:roadtrax/src/models/models.dart';
import 'package:roadtrax/src/screens/local_music/local_music_bloc.dart';
import 'package:roadtrax/src/screens/local_music/local_music_card.dart';
import 'package:location/location.dart';

class LocalMusicScreen extends StatefulWidget {
  @override
  _LocalMusicScreenState createState() => _LocalMusicScreenState();
}

class _LocalMusicScreenState extends State<LocalMusicScreen> {
  MusicFinder _audioPlayer;
  LocalMusicBloc _localMusicBloc;
  Location _location;
  List<Song> _songs = [];

  @override
  void initState() {
    _localMusicBloc = LocalMusicBloc();
    _location = Location();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _localMusicBloc.dispose();
    super.dispose();
  }

  Future<void> _functionsInit() async {
    await _requestPermissions();
    await _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = MusicFinder();
    var _tempSongs;
    try {
      _tempSongs = await MusicFinder.allSongs();
      _songs = List.from(_tempSongs);
    } catch (e) {}
  }

  Future<void> _requestPermissions() async {
    await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Bloc _globalBloc = Provider.of<Bloc>(context);
    return StreamBuilder<Profile>(
        stream: _globalBloc.profile$,
        builder:
            (BuildContext context, AsyncSnapshot<Profile> profileSnapshot) {
          if (!profileSnapshot.hasData) return Container();
          final String _userUid = profileSnapshot.data.uid;
          return FutureBuilder<void>(
              future: _functionsInit(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFF60068)),
                    ),
                  );
                }
                return Stack(
                  children: <Widget>[
                    Container(
                      color: Color(0xFF121A27),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: 12,
                          left: 4,
                          right: 4,
                          bottom: 16,
                        ),
                        itemCount: _songs.length * 2,
                        itemBuilder: (BuildContext context, int index) {
                          if (index % 2 == 1) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                height: 0,
                                color: Colors.grey[400].withOpacity(0.8),
                              ),
                            );
                          }
                          index = index ~/ 2;
                          final double _tempDuration =
                              _songs[index].duration / (1000 * 60);
                          String _seconds =
                              ((_tempDuration - _tempDuration.floor()) * 60)
                                  .round()
                                  .toString();
                          _seconds =
                              _seconds.length == 1 ? '0' + _seconds : _seconds;
                          final String _duration =
                              _tempDuration.floor().toString() + ':' + _seconds;

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Color(0xFFFE0069),
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                _audioPlayer.stop();
                                _audioPlayer.play(
                                  _songs[index].uri,
                                );
                                _localMusicBloc
                                    .playCurrentSong(_songs[index].title);
                                final _address = await _getCurrentAddress();
                                _localMusicBloc.pushCountToDatabase(
                                  _songs[index],
                                  _userUid,
                                  _address,
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: LocalMusicCard(
                                  index: index + 1,
                                  songName: _songs[index].title,
                                  genre: _songs[index].album,
                                  duration: _duration,
                                  albumArtLocation: _songs[index].albumArt,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 100,
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE0069),
                            shape: BoxShape.circle,
                          ),
                          child: StreamBuilder<MapEntry<String, String>>(
                            stream: _localMusicBloc.currentSong$,
                            initialData: MapEntry(null, "paused"),
                            builder: (BuildContext context,
                                AsyncSnapshot<MapEntry<String, String>>
                                    snapshot) {
                              final String _playerState = snapshot.data.value;
                              final String _songName = snapshot.data.key;
                              return IconButton(
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  if (_playerState == "paused") {
                                    if (_songName != null)
                                      _audioPlayer.play("temp");
                                    _localMusicBloc.playCurrentSong(_songName);
                                  } else {
                                    if (_songName != null) _audioPlayer.pause();
                                    _localMusicBloc.pauseCurrentSong(_songName);
                                  }
                                },
                                icon: _playerState == "paused" ||
                                        _songName == null
                                    ? Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 30.0,
                                      )
                                    : Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  Future<String> _getCurrentAddress() async {
    final _currentLocation = await _location.getLocation();
    final double _latitude = _currentLocation["latitude"];
    final double _longitude = _currentLocation["longitude"];
    final Coordinates _coordinates = Coordinates(_latitude, _longitude);
    final List<Address> _address =
        await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    final String _compoundName = _address.first.subAdminArea;
    return _compoundName;
  }
}
