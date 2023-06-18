import 'package:why_park/application/reservation/model/reservation_model.dart';

abstract class ReservationApplicationService {
  Future<void> registerReservation(final ReservationModel model);
}