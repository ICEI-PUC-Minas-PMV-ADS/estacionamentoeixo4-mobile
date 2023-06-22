abstract class ReservationEvents {}

class ReservationFieldsChangedEvent extends ReservationEvents {
  ReservationFieldsChangedEvent(this.label, this.value);

  final String label;
  final String value;
}

class ReservationSubmitted extends ReservationEvents {
  ReservationSubmitted(this.parkId);

  final String parkId;
}

class GetReservationsList extends ReservationEvents {}

class GetUserVehiclesListEvent extends ReservationEvents {}

class CancelReservation extends ReservationEvents {
  CancelReservation(this.uuid);

  final String uuid;
}
