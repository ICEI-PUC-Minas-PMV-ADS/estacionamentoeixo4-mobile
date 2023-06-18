import 'package:json_annotation/json_annotation.dart';

part 'reservation_resource.g.dart';

@JsonSerializable()
class ReservationResource {
  ReservationResource(this.duration, this.hour, this.parkId, this.vehicleId, this.clientId);

  @JsonKey(name: 'duracao')
  final int duration;

  @JsonKey(name: 'horario_reserva')
  final String hour;

  @JsonKey(name: 'id_estacionamento')
  final int parkId;

  @JsonKey(name: 'id_veiculo')
  final int vehicleId;

  @JsonKey(name: 'id_cliente')
  final int clientId;

  factory ReservationResource.fromJson(Map<String, dynamic> json) => _$ReservationResourceFromJson(json);


  Map<String, dynamic> toJson() => _$ReservationResourceToJson(this);
}
