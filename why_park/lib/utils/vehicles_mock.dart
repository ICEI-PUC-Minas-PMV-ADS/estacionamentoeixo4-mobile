import '../presentation/vehicle/model/vehicle_view_model.dart';

class VehicleMock {
  static List<VehicleViewModel> list = [
    VehicleViewModel(VehicleType.car, "PLZ-2345", "Honda City", "1323123"),
    VehicleViewModel(VehicleType.bike, "PXJ-2320", "yamaha R1", "132232"),
    VehicleViewModel(VehicleType.car, "PLT-2323", "Honda Civic", "12312312")
  ];
}
