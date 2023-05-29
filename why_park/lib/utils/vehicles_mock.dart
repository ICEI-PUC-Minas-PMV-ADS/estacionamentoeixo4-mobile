import '../presentation/vehicle/model/vehicle_view_model.dart';

class VehicleMock {
  static List<VehicleViewModel> list = [
    VehicleViewModel(VehicleType.car, "PLZ-2345", "Honda City"),
    VehicleViewModel(VehicleType.bike, "PXJ-2320", "yamaha R1"),
    VehicleViewModel(VehicleType.car, "PLT-2323", "Honda Civic")
  ];
}
