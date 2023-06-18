import 'package:why_park/application/reservation/model/reservation_model.dart';
import 'package:why_park/edge/converters/reservation_converter.dart';
import 'package:why_park/edge/http/custom_http_client.dart';
import 'package:why_park/edge/resources/reservation_resource.dart';

import '../../application/reservation/reservation_application_service.dart';

class ReservationQueryApplicationServiceRemoteAdapter implements ReservationApplicationService {
  ReservationQueryApplicationServiceRemoteAdapter(this._reservationConverter, this._httpClient);

  final ReservationConverter _reservationConverter;
  final CustomHttpClient _httpClient;

  @override
  Future<void> registerReservation(ReservationModel model) async {
    final ReservationResource resource = _reservationConverter.convertFrom(model);
    final response =
        await _httpClient.post('/api_producer/reserva', resource.toJson());
    print(response);
  }
}