import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGeolocatorPreferences {
  static const LAST_KNOWN_LATITUDE = "LAST_KNOWN_LATITUDE";
  static const LAST_KNOWN_LONGITUDE = "LAST_KNOWN_LONGITUDE";

  setLastKnownLocation(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(LAST_KNOWN_LATITUDE, latitude);
    prefs.setDouble(LAST_KNOWN_LONGITUDE, longitude);
  }

  Future<LatLng> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble(LAST_KNOWN_LATITUDE) ?? 37.43296265331129;
    final longitude =
        prefs.getDouble(LAST_KNOWN_LONGITUDE) ?? -122.08832357078792;
    return LatLng(latitude, longitude);
  }
}
