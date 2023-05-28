import 'package:json_annotation/json_annotation.dart';

part 'user_account_resource.g.dart';

@JsonSerializable()
class UserAccountResource {
  UserAccountResource(this.name, this.email, this.cpf);

  final String? name;
  final String? email;
  //final String? password;
  final String? cpf;

  factory UserAccountResource.fromJson(Map<String, dynamic> json) =>
      _$UserAccountResourceFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountResourceToJson(this);
}