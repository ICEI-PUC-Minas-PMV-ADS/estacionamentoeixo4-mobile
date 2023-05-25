import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class ParkState extends Equatable {
  const ParkState({
    this.latitude = 37.43296265331129,
    this.longitude = -122.08832357078792,
    this.status = Status.initial,
    this.nearestParks = const []
  });

  final double latitude;
  final double longitude;
  final Status status;
  final List<ParkViewModel> nearestParks;

  ParkState copyWith({
    double? latitude,
    double? longitude,
    Status? status,
    List<ParkViewModel>? nearestParks,
  }) {
    return ParkState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      nearestParks: nearestParks ?? this.nearestParks,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, status, nearestParks];
}