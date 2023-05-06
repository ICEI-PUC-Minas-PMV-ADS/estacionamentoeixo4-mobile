import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/edge/converters/user_account_model_to_resource_converter.dart';
import 'package:why_park/edge/http/custom_http_client.dart';

class UserRegistryApplicationServiceRemoteAdapter implements UserRegistryApplicationService {
  UserRegistryApplicationServiceRemoteAdapter(this._httpClient, this._converter);

  final CustomHttpClient _httpClient;
  final UserAccountModelToResourceConverter _converter;

  @override
  Future<void> createAccount(UserAccountModel userModel) async {
    await _httpClient.post("/api_producer/cliente", _converter.convertTo(userModel).toJson());
  }
}