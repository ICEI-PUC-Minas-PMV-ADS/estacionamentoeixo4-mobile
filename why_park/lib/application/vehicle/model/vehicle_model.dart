import '../../../presentation/vehicle/model/vehicle_view_model.dart';

class VehicleModel {
  VehicleModel(this.type, this.licensePlate, this.model, this.uuid);
  final String uuid;
  final VehicleType type;
  final String licensePlate;
  final String model;
}
