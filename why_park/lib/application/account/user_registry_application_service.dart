import 'package:why_park/application/account/model/user_account_model.dart';

abstract class UserRegistryApplicationService {
  Future<void>createAccount(UserAccountModel userModel);
}