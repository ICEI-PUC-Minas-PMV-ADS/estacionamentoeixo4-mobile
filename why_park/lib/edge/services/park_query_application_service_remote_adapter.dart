import 'package:why_park/application/park/model/park_model.dart';

import '../../application/park/park_query_application_service.dart';
import '../http/custom_http_client.dart';

class ParkQueryApplicationServiceRemoteAdapter implements ParkQueryApplicationService {
  ParkQueryApplicationServiceRemoteAdapter(this._httpClient);

  final CustomHttpClient _httpClient;

  @override
  Future<List<ParkModel>> findParksByLocation() {
    // TODO: implement findParksByLocation
    throw UnimplementedError();
  }
}