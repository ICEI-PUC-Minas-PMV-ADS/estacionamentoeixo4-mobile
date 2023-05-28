abstract class ParkEvents {}

class GetPositionEvent extends ParkEvents {}

class GetNearestParks extends ParkEvents {}

class SearchParkByAddressEvent extends ParkEvents {
  SearchParkByAddressEvent(this.value);

  final String value;
}
