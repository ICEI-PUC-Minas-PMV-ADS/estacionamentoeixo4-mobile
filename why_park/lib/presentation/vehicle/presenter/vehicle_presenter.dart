import 'package:bloc/bloc.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_state.dart';

class VehiclePresenter extends Bloc<VehicleEvents, VehicleState> {
  VehiclePresenter(this._applicationService) : super(const VehicleState()) {
    on<GetUserVehiclesListEvent>(_onGetUserVehicles);
    on<RegisterVehicleEvent>(_registerUserVehicles);
    on<UpdateVehicleEvent>(_updateUserVehicles);
    on<DeleteVehicleEvent>(_deleteUserVehicles);
  }

  final VehicleQueryApplicationService _applicationService;

  Future<void> _onGetUserVehicles(final GetUserVehiclesListEvent event,
      final Emitter<VehicleState> emit) async {}

  Future<void> _registerUserVehicles(final RegisterVehicleEvent event,
      final Emitter<VehicleState> emit) async {}

  Future<void> _updateUserVehicles(
      final UpdateVehicleEvent event, final Emitter<VehicleState> emit) async {}

  Future<void> _deleteUserVehicles(
      final DeleteVehicleEvent event, final Emitter<VehicleState> emit) async {}
}
