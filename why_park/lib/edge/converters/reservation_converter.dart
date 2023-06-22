import 'package:why_park/edge/resources/reservation_resource.dart';

import '../../application/reservation/model/reservation_model.dart';

class ReservationConverter {
  ReservationModel convertTo(final ReservationResource resource) {
    return ReservationModel(
      resource.id,
      resource.duration,
      resource.hour,
      resource.parkId,
      resource.vehicleId,
      resource.clientId,
    );
  }

  ReservationResource convertFrom(final ReservationModel model) {
    return ReservationResource(
      model.id,
      model.duration,
      model.hour,
      model.parkId,
      model.vehicleId,
      model.clientId,
    );
  }
}
