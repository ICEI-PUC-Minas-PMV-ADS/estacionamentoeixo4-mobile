import 'package:json_annotation/json_annotation.dart';

part 'user_resource.g.dart';

@JsonSerializable()
class UserResource {
  UserResource(this.name, this.email, this.cpf, this.uuid);


  final String? name;
  final String? email;
  final String? cpf;
  @JsonKey(name: 'uuid_firebase')
  final String? uuid;

  factory UserResource.fromJson(Map<String, dynamic> json) => _$UserResourceFromJson(json);


  Map<String, dynamic> toJson() => _$UserResourceToJson(this);
}
