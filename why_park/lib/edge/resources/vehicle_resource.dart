import 'package:json_annotation/json_annotation.dart';

part 'vehicle_resource.g.dart';

@JsonSerializable()
class VehicleResource {
  VehicleResource(this.id, this.tipo, this.placa, this.modelo, this.clientId);

  final int? id;
  final String? placa;
  final String? tipo;
  final String? modelo;
  @JsonKey(name: 'id_cliente')
  final int? clientId;

  factory VehicleResource.fromJson(Map<String, dynamic> json) =>
      _$VehicleResourceFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResourceToJson(this);
}
