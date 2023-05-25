import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:why_park/commons/commons_geolocator/user_geolocator_preferences.dart';

class UserGeolocatorProvider with ChangeNotifier {
  UserGeolocatorPreferences darkThemePreference = UserGeolocatorPreferences();

  LatLng _location = const LatLng(37.43296265331129, -122.08832357078792);

  LatLng get location => _location;

  set location (LatLng location) {
    _location = location;
    darkThemePreference.setLastKnownLocation(
        location.latitude, location.longitude);
    notifyListeners();
  }
}
