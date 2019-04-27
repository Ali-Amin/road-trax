import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:roadtrax/src/screens/maps/map_songs_screen.dart';
import 'package:roadtrax/src/screens/maps/maps_screen_bloc.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _mapController;
  Location _location;
  MapsScreenBloc _mapsScreenBloc;

  @override
  void initState() {
    _mapController = Completer();
    _location = Location();
    _mapsScreenBloc = MapsScreenBloc();
    _mapsScreenBloc.songs$.listen((data) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapSongsScreen(
                songs: data,
              ),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _mapsScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(30.0444, 31.2357),
            zoom: 14,
          ),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
            _animateToCurrentPosition();
          },
          myLocationEnabled: true,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 40,
              width: 150,
              child: FlatButton(
                color: Color(0xFFF60068),
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () => _onPressed(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.library_music,
                      color: Colors.white,
                    ),
                    Text(
                      "Get Songs",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onPressed() async {
    _showLoadingDialog();
    final String _address = await _getCurrentAddress();
    _mapsScreenBloc.updateSongs(_address);
  }

  void _showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFF60068)),
                  ),
                ),
                Text(
                  "Loading",
                  style: TextStyle(
                    color: Color(0xFFF60068),
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

  Future<CameraPosition> _getCurrentCameraLocation() async {
    final _currentLocation = await _location.getLocation();
    final CameraPosition _currentCameraPostion = CameraPosition(
      target:
          LatLng(_currentLocation["latitude"], _currentLocation["longitude"]),
      zoom: 17.5,
    );
    return _currentCameraPostion;
  }

  Future<void> _animateToCurrentPosition() async {
    final CameraPosition _currentCameraPosition =
        await _getCurrentCameraLocation();
    final GoogleMapController _controller = await _mapController.future;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(_currentCameraPosition),
    );
  }
}
