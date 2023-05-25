abstract class ParkDetailEvents {}

class GetDirectionEvent extends ParkDetailEvents {
  GetDirectionEvent(this.originLatitude, this.destinationLatitude, this.originLongitude, this.destinationLongitude);

  final double originLatitude;
  final double destinationLatitude;
  final double originLongitude;
  final double destinationLongitude;
}