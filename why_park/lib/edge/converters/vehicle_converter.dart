import 'package:why_park/application/vehicle/model/vehicle_model.dart';
import 'package:why_park/edge/resources/vehicle_resource.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';

import '../session_storage/session_storage.dart';

class VehicleConverter {
  VehicleConverter(this._sessionStorage);

  final SessionStorage _sessionStorage;

  VehicleModel convertTo(VehicleResource resource) {
    return VehicleModel(
        resource.id,
        VehicleType.values
            .firstWhere((element) => element.name == resource.tipo),
        resource.placa,
        resource.modelo);
  }

  Future<VehicleResource> convertFrom(VehicleModel model) async {
    final String id = await _sessionStorage.retrieveId() ?? '';

    return VehicleResource(
      model.uuid,
      model.type?.name,
      model.licensePlate,
      model.model,
      int.parse(id),
    );
  }
}
