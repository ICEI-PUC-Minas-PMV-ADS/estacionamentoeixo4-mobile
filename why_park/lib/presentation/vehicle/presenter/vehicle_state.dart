import 'dart:ffi';

import 'package:equatable/equatable.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class VehicleState extends Equatable {
  const VehicleState({
    this.type = '',
    this.licensePlate = '',
    this.model = '',
    this.hasSpecialNeeds = false,
    this.status = Status.initial,
  });

  final String type;
  final String licensePlate;
  final String model;
  final bool hasSpecialNeeds;
  final Status status;

  VehicleState copyWith({
    String? type,
    String? licensePlate,
    String? model,
    bool? hasSpecialNeeds,
    Status? status,
  }) {
    return VehicleState(
      type: type ?? this.type,
      licensePlate: licensePlate ?? this.licensePlate,
      model: model ?? this.model,
      hasSpecialNeeds: hasSpecialNeeds ?? this.hasSpecialNeeds,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [type, licensePlate, model, hasSpecialNeeds, status];
}
