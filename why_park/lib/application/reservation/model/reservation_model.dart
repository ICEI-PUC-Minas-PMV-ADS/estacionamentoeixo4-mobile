class ReservationModel {
  ReservationModel(this.id, this.duration, this.hour, this.parkId,
      this.vehicleId, this.clientId);

  final int id;

  final int duration;

  final String hour;

  final int parkId;

  final int vehicleId;

  final int clientId;
}
