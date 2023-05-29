import '../model/vehicle_view_model.dart';

abstract class VehicleEvents {}

class GetUserVehiclesListEvent extends VehicleEvents {}

class RegisterVehicleEvent extends VehicleEvents {
  RegisterVehicleEvent(this.viewModel);

  final VehicleViewModel viewModel;
}

class UpdateVehicleEvent extends VehicleEvents {
  UpdateVehicleEvent(this.uuid);

  final String uuid;
}

class DeleteVehicleEvent extends VehicleEvents {
  DeleteVehicleEvent(this.uuid);

  final String uuid;
}
