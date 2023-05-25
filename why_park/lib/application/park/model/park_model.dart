class ParkModel {
  ParkModel(this.latitude, this.longitude, this.name, this.address, this.rating, this.pricePerHour, this.priorityVacancies, this.vacancies);

  final double latitude;
  final double longitude;
  final String name;
  final String address;
  final double rating;
  final double pricePerHour;
  final int priorityVacancies;
  final int vacancies;
}
