import 'package:why_park/application/vehicle/model/vehicle_model.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/edge/resources/vehicle_resource.dart';

import '../converters/vehicle_converter.dart';
import '../http/custom_http_client.dart';
import '../session_storage/session_storage.dart';

class VehicleQueryApplicationServiceRemoteAdapter
    implements VehicleQueryApplicationService {
  VehicleQueryApplicationServiceRemoteAdapter(
      this._httpClient, this._converter, this._sessionStorage);

  final CustomHttpClient _httpClient;
  final VehicleConverter _converter;
  final SessionStorage _sessionStorage;

  @override
  Future<void> deleteUserVehicle(String uuid) async {
    await _httpClient.delete('/api_producer/veiculo/${uuid}');
  }

  @override
  Future<List<VehicleModel>> findUserVehicles() async {
    final String id = await _sessionStorage.retrieveId() ?? '';

    final response = await _httpClient
        .get("/api_producer/veiculo/cliente/$id")
        .then((value) => value.body);

    final List<VehicleResource> vehicleList = List<VehicleResource>.from(
        response.map((e) => VehicleResource.fromJson(e)));

    return List<VehicleModel>.from(
        vehicleList.map((e) => _converter.convertTo(e)).toList());
  }

  @override
  Future<void> registerUserVehicle(VehicleModel model) async {
    final VehicleResource resource = await _converter.convertFrom(model);

    await _httpClient.post('/api_producer/veiculo', resource.toJson());
  }

  @override
  Future<void> updateUserVehicle(VehicleModel model) async {
    final VehicleResource resource = await _converter.convertFrom(model);

    await _httpClient.patch(
        '/api_producer/veiculo/${model.uuid.toString()}', resource.toJson());
  }
}
