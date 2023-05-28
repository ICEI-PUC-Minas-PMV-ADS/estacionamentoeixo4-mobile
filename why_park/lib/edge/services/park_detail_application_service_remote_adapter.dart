import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:why_park/application/park/park_detail_application_service.dart';


class ParkDetailApplicationServiceRemoteAdapter
    extends ParkDetailApplicationService {
  ParkDetailApplicationServiceRemoteAdapter();


  @override
  Future<Map<String, dynamic>> getDirections(String origin, String destination) async {
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&key=AIzaSyDRANEr71X4-tfM6Wua8TESB7XskoXUTgI';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    var results = {
      'bound_ne': json['routes'][0]['bounds']['northeast'],
      'bound_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    return results;
  }

}
