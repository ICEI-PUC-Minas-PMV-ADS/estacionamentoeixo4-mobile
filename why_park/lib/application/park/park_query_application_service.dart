import 'package:why_park/application/park/model/park_model.dart';

abstract class ParkQueryApplicationService {
  Future<List<ParkModel>>findParksByLocation();
}
