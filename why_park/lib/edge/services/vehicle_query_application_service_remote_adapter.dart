import 'package:why_park/application/vehicle/model/vehicle_model.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/edge/resources/vehicle_resource.dart';

import '../converters/vehicle_converter.dart';
import '../http/custom_http_client.dart';

class VehicleQueryApplicationServiceRemoteAdapter
    implements VehicleQueryApplicationService {
  VehicleQueryApplicationServiceRemoteAdapter(
      this._httpClient, this._converter);

  final CustomHttpClient _httpClient;
  final VehicleConverter _converter;

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
  Future<void> registerUserVehicle(VehicleModel model) async {
    final VehicleResource resource = await _converter.convertFrom(model);

    await _httpClient.post('/api_producer/veiculo', resource.toJson());
  }

  @override
  Future<void> updateUserVehicle(VehicleModel model) {
    // TODO: implement updateUserVehicle
    throw UnimplementedError();
  }
}
