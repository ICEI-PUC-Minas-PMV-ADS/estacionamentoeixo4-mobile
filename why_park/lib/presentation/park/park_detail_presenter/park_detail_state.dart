import 'package:equatable/equatable.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class ParkDetailState extends Equatable {
  const ParkDetailState({
    this.latitude = 37.43296265331129,
    this.longitude = -122.08832357078792,
    this.status = Status.initial,
    this.direction = const {},
  });

  final double latitude;
  final double longitude;
  final Status status;
  final Map<String, dynamic> direction;

  ParkDetailState copyWith({
    double? latitude,
    double? longitude,
    Status? status,
    final Map<String, dynamic>? direction,
  }) {
    return ParkDetailState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      direction: direction ?? this.direction,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, status, direction];
}
