import 'package:json_annotation/json_annotation.dart';

part 'park_resource.g.dart';

@JsonSerializable()
class ParkResource {
  ParkResource(
    this.latitude,
    this.longitude,
    this.name,
    this.address,
    this.rating,
    this.pricePerHour,
    this.priorityVacancies,
    this.vacancies,
  );

  final double? latitude;
  final double? longitude;
  final String? name;
  final String? address;
  final double? rating;
  final double? pricePerHour;
  final int? priorityVacancies;
  final int? vacancies;

  factory ParkResource.fromJson(Map<String, dynamic> json) =>
      _$ParkResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ParkResourceToJson(this);
}
