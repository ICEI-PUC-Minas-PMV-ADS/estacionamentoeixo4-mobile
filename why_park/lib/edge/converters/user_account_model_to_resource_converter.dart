import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/edge/resources/user_account_resource.dart';

class UserAccountModelToResourceConverter {
  // poderia existir uma interface converter
  UserAccountResource convertTo(UserAccountModel source) {
    return UserAccountResource(
        source.name, source.email, "12345678910");
  }
}
