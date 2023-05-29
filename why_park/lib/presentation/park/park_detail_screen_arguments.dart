import 'package:why_park/presentation/park/view_model/park_view_model.dart';

class ParkDetailScreenArguments {
  final ParkViewModel viewModel;
  final double personalLatitude;
  final double personalLongitude;

  ParkDetailScreenArguments(
    this.viewModel,
    this.personalLatitude,
    this.personalLongitude,
  );
}
