import 'package:why_park/application/park/model/park_model.dart';
import 'package:why_park/edge/resources/park_resource.dart';

class ParkResourceToModelConverter {

  static const String _latKey = 'lat';
  static const String _lgtKey = 'lgt';
  static const String _address = 'endereco';
  static const String _district = 'bairro';
  static const String _addressNumber = 'numero';

  // poderia existir uma interface converter
  ParkModel convertTo(ParkResource resource) {
    return ParkModel(
      resource.id,
      resource.address?.first[_latKey],
      resource.address?.first[_lgtKey],
      resource.name,
      resource.address?.first[_address] + '-' + resource.address?.first[_district] + '-' + resource.address?.first[_addressNumber],
      4,
      resource.price,
      resource.priorityVacancies,
      resource.vacancies,
    );
  }
}
