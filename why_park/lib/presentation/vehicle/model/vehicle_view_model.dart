enum VehicleType { car, bike }

class VehicleViewModel {
  VehicleViewModel(this.type, this.licensePlate, this.model, this.uuid);
  final String uuid;
  final VehicleType type;
  final String licensePlate;
  final String model;
}
