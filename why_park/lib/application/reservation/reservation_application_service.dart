import 'package:why_park/application/reservation/model/reservation_model.dart';

abstract class ReservationApplicationService {
  Future<List<ReservationModel>> getReservation();

  Future<void> registerReservation(final ReservationModel model);

  Future<void> cancelReservation(final int uuid);
}
