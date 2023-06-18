abstract class ReservationEvents {}

class ReservationFieldsChangedEvent extends ReservationEvents {
  ReservationFieldsChangedEvent(this.label, this.value);

  final String label;
  final String value;
}

class ReservationSubmitted extends ReservationEvents {}