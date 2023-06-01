import 'package:firebase_auth/firebase_auth.dart';
import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';

class UserAuthApplicationServiceRemoteAdapter
    implements UserAuthApplicationService {

  @override
  Future<void> loginWithEmailAndPassword(final UserAccountModel model) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      print(userCredential);
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
    } catch (e) {
      throw Exception('signUpWithEmailAndPassword.error: $e');
    }
  }
}
