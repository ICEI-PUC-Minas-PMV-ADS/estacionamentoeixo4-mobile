// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountResource _$UserAccountResourceFromJson(Map<String, dynamic> json) =>
    UserAccountResource(
      json['name'] as String?,
      json['email'] as String?,
      json['cpf'] as String?,
    );

Map<String, dynamic> _$UserAccountResourceToJson(
        UserAccountResource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cpf': instance.cpf,
    };
