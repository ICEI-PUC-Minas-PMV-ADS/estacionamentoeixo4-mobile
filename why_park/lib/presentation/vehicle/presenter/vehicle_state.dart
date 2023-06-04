import 'package:equatable/equatable.dart';

import '../model/vehicle_view_model.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class VehicleState extends Equatable {
  const VehicleState({
    this.usersVehicles = const [],
    this.hasSpecialNeeds = false,
    this.status = Status.initial,
  });

  final List<VehicleViewModel> usersVehicles;
  final bool hasSpecialNeeds;
  final Status status;

  VehicleState copyWith({
    List<VehicleViewModel>? usersVehicles,
    bool? hasSpecialNeeds,
    Status? status,
  }) {
    return VehicleState(
      usersVehicles: usersVehicles ?? this.usersVehicles,
      hasSpecialNeeds: hasSpecialNeeds ?? this.hasSpecialNeeds,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [usersVehicles, hasSpecialNeeds, status];
}
