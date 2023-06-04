class ParkModel {
  ParkModel(this.id, this.latitude, this.longitude, this.name, this.address, this.rating, this.pricePerHour, this.priorityVacancies, this.vacancies);

  final int? id;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? address;
  final double? rating;
  final String? pricePerHour;
  final int? priorityVacancies;
  final int? vacancies;
}
