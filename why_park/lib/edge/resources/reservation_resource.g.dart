// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationResource _$ReservationResourceFromJson(Map<String, dynamic> json) =>
    ReservationResource(
      json['duracao'] as int,
      json['horario_reserva'] as String,
      json['id_estacionamento'] as int,
      json['id_veiculo'] as int,
      json['id_cliente'] as int,
    );

Map<String, dynamic> _$ReservationResourceToJson(
        ReservationResource instance) =>
    <String, dynamic>{
      'duracao': instance.duration,
      'horario_reserva': instance.hour,
      'id_estacionamento': instance.parkId,
      'id_veiculo': instance.vehicleId,
      'id_cliente': instance.clientId,
    };
