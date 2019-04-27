import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:roadtrax/src/screens/home/home_screen_bloc.dart';
import '../maps/maps.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc;
  final List<String> _pageTitles = [
    "Stream Music",
    "Map View",
    "Local Music",
  ];

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
        title: StreamBuilder<int>(
          stream: _homeScreenBloc.pageIndex$,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final int _pageIndex = snapshot.data;
            return Text(_pageTitles[_pageIndex]);
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
          TabData(
            iconData: Icons.settings_system_daydream,
            title: _pageTitles[0],
          ),
          TabData(
            iconData: Icons.map,
            title: _pageTitles[1],
          ),
          TabData(
            iconData: Icons.music_note,
            title: _pageTitles[2],
          ),
        ],
        onTabChangedListener: (int index) async {
          await Future.delayed(Duration(milliseconds: 150));
          _homeScreenBloc.sendPageIndex(index);
        },
      ),
      body: StreamBuilder<int>(
        stream: _homeScreenBloc.pageIndex$,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final int _pageIndex = snapshot.data;
          switch (_pageIndex) {
            case 0:
              return Container(
                color: Colors.white,
              );
              break;
            case 1:
              return MapsScreen();
              break;
            case 2:
              return Container(
                color: Colors.green,
              );
              break;
            default:
              return CircularProgressIndicator();
              break;
          }
        },
      ),
    );
  }
}
