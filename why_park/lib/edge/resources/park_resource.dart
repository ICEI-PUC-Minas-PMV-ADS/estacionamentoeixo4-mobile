import 'package:json_annotation/json_annotation.dart';

part 'park_resource.g.dart';

@JsonSerializable(ignoreUnannotated: true, includeIfNull: true)
class ParkResource {
  ParkResource(
    this.id,
    this.name,
    this.address,
    this.price,
    this.priorityVacancies,
    this.vacancies,
  );

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'razao_social')
  final String? name;

  @JsonKey(name: 'Endereco')
  final List<Map<String, dynamic>>? address;

  @JsonKey(name: 'preco')
  final double? price;

  @JsonKey(name: 'vagas_preferenciais')
  final int? priorityVacancies;

  @JsonKey(name: 'vagas_gerais')
  final int? vacancies;

  factory ParkResource.fromJson(Map<String, dynamic> json) =>
      _$ParkResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ParkResourceToJson(this);
}
