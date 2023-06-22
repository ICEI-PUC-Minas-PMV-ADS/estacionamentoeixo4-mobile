import 'package:why_park/application/reservation/model/reservation_model.dart';
import 'package:why_park/edge/converters/reservation_converter.dart';
import 'package:why_park/edge/http/custom_http_client.dart';
import 'package:why_park/edge/resources/reservation_resource.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';

import '../../application/reservation/reservation_application_service.dart';

class ReservationQueryApplicationServiceRemoteAdapter
    implements ReservationApplicationService {
  ReservationQueryApplicationServiceRemoteAdapter(
      this._reservationConverter, this._httpClient, this._sessionStorage);

  final ReservationConverter _reservationConverter;
  final CustomHttpClient _httpClient;
  final SessionStorage _sessionStorage;

  @override
  Future<void> registerReservation(ReservationModel model) async {
    final ReservationResource resource =
        _reservationConverter.convertFrom(model);
    final response =
        await _httpClient.post('/api_producer/reserva', resource.toJson());
  }

  @override
  Future<void> cancelReservation(final int uuid) async {
    await _httpClient.patch('/api_producer/reserva/cancelar/${uuid.toString()}');
  }

  @override
  Future<List<ReservationModel>> getReservation() async {
    final String id = await _sessionStorage.retrieveId() ?? '';

    final response = await _httpClient
        .get("/api_producer/reserva/cliente/$id")
        .then((value) => value.body);

    final List<ReservationResource> reservationList =
        List<ReservationResource>.from(
            response.map((e) => ReservationResource.fromJson(e)));

    return List<ReservationModel>.from(reservationList
        .map((e) => _reservationConverter.convertTo(e))
        .toList());
  }
}
