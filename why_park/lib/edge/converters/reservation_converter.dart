import 'package:why_park/edge/resources/reservation_resource.dart';

import '../../application/reservation/model/reservation_model.dart';

class ReservationConverter {
  ReservationModel convertTo(final ReservationResource resource) {
    return ReservationModel(
      resource.duration,
      resource.hour,
      resource.parkId,
      resource.vehicleId,
      resource.clientId,
    );
  }

  ReservationResource convertFrom(final ReservationModel model) {
    return ReservationResource(
      model.duration,
      model.hour,
      model.parkId,
      model.vehicleId,
      model.clientId,
    );

    final ReservationResource resource = ReservationResource(
        3,
        DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
          DateTime.now().millisecond,
          DateTime.now().microsecond,
        ).toIso8601String(),
        6,
        1,
        6);
  }
}
