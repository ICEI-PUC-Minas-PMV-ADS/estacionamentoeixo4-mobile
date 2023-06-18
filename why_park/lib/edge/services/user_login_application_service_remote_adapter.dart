import 'package:firebase_auth/firebase_auth.dart';
import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/edge/resources/user_resource.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';

import '../http/custom_http_client.dart';

class UserAuthApplicationServiceRemoteAdapter
    implements UserAuthApplicationService {
  UserAuthApplicationServiceRemoteAdapter(this._sessionStorage, this._httpClient);

  final SessionStorage _sessionStorage;
  final CustomHttpClient _httpClient;

  @override
  Future<void> loginWithEmailAndPassword(final UserAccountModel model) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: model.email, password: model.password);

      User? user = userCredential.user;

      user != null ? await _sessionStorage.saveSession(user.uid) : throw Exception();
    } catch (e) {
      throw Exception('loginWithEmailAndPassword.error: $e');
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(final UserAccountModel model) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      User? user = userCredential.user;

      user?.email != null ? await _sessionStorage.saveEmail(user!.email!) : throw Exception();
      await _sessionStorage.saveUserName(user.email!, model.name);
      final UserResource userResource = UserResource(model.name, user.email!, '12345678910', user.uid);

      final response = await _httpClient.post('/api_producer/cliente', userResource.toJson());
      await _sessionStorage.saveClientId(response.body['id'].toString());
    } catch (e) {
      throw Exception('signUpWithEmailAndPassword.error: $e');
    }
  }
}
