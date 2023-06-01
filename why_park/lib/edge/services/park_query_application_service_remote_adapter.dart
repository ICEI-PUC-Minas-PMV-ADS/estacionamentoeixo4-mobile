import 'package:why_park/application/park/model/park_model.dart';
import 'package:why_park/edge/converters/park_resource_to_model_converter.dart';
import 'package:why_park/edge/resources/park_resource.dart';

import '../../application/park/park_query_application_service.dart';
import '../http/custom_http_client.dart';

class ParkQueryApplicationServiceRemoteAdapter implements ParkQueryApplicationService {
  ParkQueryApplicationServiceRemoteAdapter(this._httpClient, this._converter);

  final CustomHttpClient _httpClient;
  final ParkResourceToModelConverter _converter;

  @override
  Future<List<ParkModel>> findParksByLocation() async {
    final list = await _httpClient.get("/api_producer/cliente").then((value) => value.body) as List<ParkResource>;
    return list.map((e) => _converter.convertTo(e)).toList();
  }
}