class ReservationViewModel {
  final String id;
  final String date;

  // final String vehicle;
  final String duration;
  final bool hasExpired;

  ReservationViewModel(this.id, this.date, this.duration, this.hasExpired);
}
