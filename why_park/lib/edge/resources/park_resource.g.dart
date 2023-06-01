// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkResource _$ParkResourceFromJson(Map<String, dynamic> json) => ParkResource(
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      json['name'] as String?,
      json['address'] as String?,
      (json['rating'] as num?)?.toDouble(),
      (json['pricePerHour'] as num?)?.toDouble(),
      json['priorityVacancies'] as int?,
      json['vacancies'] as int?,
    );

Map<String, dynamic> _$ParkResourceToJson(ParkResource instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'address': instance.address,
      'rating': instance.rating,
      'pricePerHour': instance.pricePerHour,
      'priorityVacancies': instance.priorityVacancies,
      'vacancies': instance.vacancies,
    };
