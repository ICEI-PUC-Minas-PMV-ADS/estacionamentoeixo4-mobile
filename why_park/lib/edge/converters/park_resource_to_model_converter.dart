import 'package:why_park/application/park/model/park_model.dart';
import 'package:why_park/edge/resources/park_resource.dart';

class ParkResourceToModelConverter {
  // poderia existir uma interface converter
  ParkModel convertTo(ParkResource resource) {
    return ParkModel(
      resource.latitude,
      resource.longitude,
      resource.name,
      resource.address,
      resource.rating,
      resource.pricePerHour,
      resource.priorityVacancies,
      resource.vacancies,
    );
  }
}
