import 'package:why_park/application/vehicle/model/vehicle_model.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';

import '../http/custom_http_client.dart';

class VehicleQueryApplicationServiceRemoteAdapter implements VehicleQueryApplicationService {
  VehicleQueryApplicationServiceRemoteAdapter(this._httpClient);

  final CustomHttpClient _httpClient;

  @override
  Future<void> deleteUserVehicle(String uuid) {
    // TODO: implement deleteUserVehicle
    throw UnimplementedError();
  }

  @override
  Future<List<VehicleModel>> findUserVehicles() {
    // TODO: implement findUserVehicles
    throw UnimplementedError();
  }

  @override
  Future<void> registerUserVehicle(VehicleModel model) {
    // TODO: implement registerUserVehicle
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserVehicle(VehicleModel model) {
    // TODO: implement updateUserVehicle
    throw UnimplementedError();
  }

}