// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleResource _$VehicleResourceFromJson(Map<String, dynamic> json) =>
    VehicleResource(
      json['id'] as int?,
      json['tipo'] as String?,
      json['placa'] as String?,
      json['modelo'] as String?,
      json['id_cliente'] as int?,
    );

Map<String, dynamic> _$VehicleResourceToJson(VehicleResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placa': instance.placa,
      'tipo': instance.tipo,
      'modelo': instance.modelo,
      'id_cliente': instance.clientId,
    };
