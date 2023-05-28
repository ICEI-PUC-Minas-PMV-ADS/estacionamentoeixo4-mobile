import 'package:why_park/application/vehicle/model/vehicle_model.dart';

abstract class VehicleQueryApplicationService {
  Future<List<VehicleModel>> findUserVehicles();

  Future<void> registerUserVehicle(final VehicleModel model);

  Future<void> updateUserVehicle(final VehicleModel model);

  Future<void> deleteUserVehicle(final String uuid);
}
