// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkResource _$ParkResourceFromJson(Map<String, dynamic> json) => ParkResource(
      json['id'] as int?,
      json['razao_social'] as String?,
      (json['Endereco'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      json['preco'] as String?,
      json['vagas_preferenciais'] as int?,
      json['vagas_gerais'] as int?,
    );

Map<String, dynamic> _$ParkResourceToJson(ParkResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'razao_social': instance.name,
      'Endereco': instance.address,
      'preco': instance.price,
      'vagas_preferenciais': instance.priorityVacancies,
      'vagas_gerais': instance.vacancies,
    };
