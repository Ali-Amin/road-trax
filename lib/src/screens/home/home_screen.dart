import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:roadtrax/src/screens/home/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc;

  @override
  void initState() {
    _homeScreenBloc = HomeScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homeScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121A27),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1C222E),
        title: StreamBuilder<String>(
          stream: _homeScreenBloc.titles$,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final String _title = snapshot.data;
            return Text(_title);
          },
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        barBackgroundColor: Color(0xFFF60068),
        circleColor: Colors.white,
        textColor: Colors.white,
        activeIconColor: Color(0xFFF3006A),
        inactiveIconColor: Colors.white,
        tabs: [
          TabData(iconData: Icons.settings_system_daydream, title: "Home"),
          TabData(iconData: Icons.map, title: "Search"),
          TabData(iconData: Icons.music_note, title: "Basket")
        ],
        onTabChangedListener: (int index) {
          _homeScreenBloc.sendIndex(index);
        },
      ),
    );
  }
}
