import '../presentation/reservation/view_model/reservation_view_model.dart';

class ReservationMock {
  static List<ReservationViewModel> reservationViewModels = [
    ReservationViewModel('00023', '08/06/2023', '3 horas', false),
    ReservationViewModel('00014', '07/06/2023', '2 horas', false),
    ReservationViewModel('00025', '04/06/2023', '4 horas', false),
  ];

  static List<ReservationViewModel> expiredReservationViewModels = [
    ReservationViewModel('00021', '04/05/2023', '2 horas', true),
    ReservationViewModel('00022', '04/03/2023', '1 horas', true),
    ReservationViewModel('00026', '10/02/2023', '3 horas', true),
    ReservationViewModel('00027', '15/02/2023', '1 horas', true),
    ReservationViewModel('00028', '22/01/2023', '2 horas', true),
    ReservationViewModel('00029', '12/04/2023', '3 horas', true),
    ReservationViewModel('00020', '04/06/2023', '4 horas', true),
  ];
}
