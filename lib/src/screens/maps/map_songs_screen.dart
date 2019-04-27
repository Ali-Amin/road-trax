import 'package:flutter/material.dart';

class MapSongsScreen extends StatelessWidget {
  final Map<String, num> _songs;

  MapSongsScreen({@required Map<String, num> songs}) : _songs = songs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121A27),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1C222E),
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
    );
  }
}
