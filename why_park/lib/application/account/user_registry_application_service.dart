import 'package:why_park/application/account/model/user_account_model.dart';

abstract class UserAuthApplicationService {
  Future<void> loginWithEmailAndPassword(final UserAccountModel model);

  Future<void> signUpWithEmailAndPassword(final UserAccountModel model);

  Future<void> loginWithGoogle();
}