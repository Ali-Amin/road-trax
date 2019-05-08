import 'package:flutter/material.dart';

class LocalMusicCard extends StatefulWidget {
  int _index;
  String _songName;
  String _genre;
  String _duartion;
  String _albumArtLocation;
  LocalMusicCard({
    @required String songName,
    @required String genre,
    @required int index,
    @required String duration,
    @required String albumArtLocation,
  })  : _songName = songName,
        _genre = genre,
        _index = index,
        _duartion = duration,
        _albumArtLocation = albumArtLocation;

  @override
  _LocalMusicCardState createState() => _LocalMusicCardState();
}

class _LocalMusicCardState extends State<LocalMusicCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 65,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    widget._index.toString(),
                    style: TextStyle(
                      color: Color(0xFFFE0069),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[600].withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: widget._albumArtLocation != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            widget._albumArtLocation,
                            fit: BoxFit.cover,
                          ))
                      : Center(
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white.withOpacity(0.8),
                            size: 45.0,
                          ),
                        ),
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._songName,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget._genre,
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Center(
                      child: Text(
                        widget._duartion,
                        style: TextStyle(
                          color: Color(0xFFFE0069),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
