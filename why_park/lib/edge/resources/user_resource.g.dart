// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResource _$UserResourceFromJson(Map<String, dynamic> json) => UserResource(
      json['name'] as String?,
      json['email'] as String?,
      json['cpf'] as String?,
      json['uuid_firebase'] as String?,
    );

Map<String, dynamic> _$UserResourceToJson(UserResource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cpf': instance.cpf,
      'uuid_firebase': instance.uuid,
    };
