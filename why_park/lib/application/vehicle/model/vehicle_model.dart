import '../../../presentation/vehicle/model/vehicle_view_model.dart';

class VehicleModel {
  VehicleModel( this.uuid, this.type, this.licensePlate, this.model);
  final int? uuid;
  final VehicleType? type;
  final String? licensePlate;
  final String? model;
}
