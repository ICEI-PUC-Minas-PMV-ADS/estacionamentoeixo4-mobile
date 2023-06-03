class ParkViewModel {
  ParkViewModel(
    this.id,
    this.name,
    this.address,
    this.distanceForMe,
    this.latitude,
    this.longitude,
    this.rating,
    this.pricePerHour,
    this.priorityVacancies,
    this.vacancies,
  );

  final String id;
  final String name;
  final String address;
  final double distanceForMe;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final double? pricePerHour;
  final int? priorityVacancies;
  final int? vacancies;
}
