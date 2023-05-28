
import '../model/vehicle_view_model.dart';

abstract class VehicleEvents {}

class GetUserVehiclesListEvent extends VehicleEvents {}

class RegisterVehicleEvent extends VehicleEvents {
  final VehicleViewModel viewModel;

  RegisterVehicleEvent(this.viewModel);
}

class UpdateVehicleEvent extends VehicleEvents {
  final String uuid;

  UpdateVehicleEvent(this.uuid);
}

class DeleteVehicleEvent extends VehicleEvents {
  final String uuid;

  DeleteVehicleEvent(this.uuid);
}