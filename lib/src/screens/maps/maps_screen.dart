import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _mapController;
  Location _location;

  @override
  void initState() {
    _mapController = Completer();
    _location = Location();
    _getCurrentAddress();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
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
    );
  }

  Future<void> _getCurrentAddress() async {
    final _currentLocation = await _location.getLocation();
    final double _latitude = _currentLocation["latitude"];
    final double _longitude = _currentLocation["longitude"];
    final Coordinates _coordinates = Coordinates(_latitude, _longitude);
    final List<Address> _address =
        await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    final String _compoundName = _address.first.subAdminArea;
  }

  Future<CameraPosition> _getCurrentCameraLocation() async {
    final _currentLocation = await _location.getLocation();
    final CameraPosition _currentCameraPostion = CameraPosition(
      target:
          LatLng(_currentLocation["latitude"], _currentLocation["longitude"]),
      zoom: 16,
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
