import 'package:flutter/material.dart';
import 'package:roadtrax/src/common/music_card_bloc.dart';

class MusicCard extends StatefulWidget {
  int _index;
  String _songName;
  String _genre;
  num _count;
  MusicCard(
      {@required String songName,
      @required String genre,
      @required int index,
      @required num count})
      : _songName = songName,
        _genre = genre,
        _index = index,
        _count = count;

  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  MusicCardBloc _musicCardBloc;

  @override
  void initState() {
    _musicCardBloc = MusicCardBloc();
    super.initState();
  }

  @override
  void dispose() {
    _musicCardBloc.dispose();
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
                      fontSize: 20.0,
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
                  child: Center(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StreamBuilder<bool>(
                          stream: _musicCardBloc.favourite$,
                          initialData: false,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            final _isFavourite = snapshot.data;
                            return IconButton(
                              onPressed: () =>
                                  _musicCardBloc.triggerFavourite(),
                              icon: Icon(
                                _isFavourite ? Icons.star : Icons.star_border,
                                size: 22.0,
                                color: Color(0xFFFE0069),
                              ),
                            );
                          },
                        ),
                        Text(
                          widget._count.toString(),
                          style: TextStyle(
                            color: Color(0xFFFE0069),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            height: 20.0,
            color: Colors.grey[400].withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
