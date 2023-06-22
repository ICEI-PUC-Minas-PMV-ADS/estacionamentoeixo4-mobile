import 'package:bloc/bloc.dart';
import 'package:why_park/application/vehicle/model/vehicle_model.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_state.dart';
import 'package:why_park/utils/vehicles_mock.dart';

class VehiclePresenter extends Bloc<VehicleEvents, VehicleState> {
  VehiclePresenter(this._applicationService) : super(const VehicleState()) {
    on<GetUserVehiclesListEvent>(_onGetUserVehicles);
    on<RegisterVehicleEvent>(_registerUserVehicles);
    on<UpdateVehicleEvent>(_updateUserVehicles);
    on<DeleteVehicleEvent>(_deleteUserVehicles);
  }

  final VehicleQueryApplicationService _applicationService;

  Future<void> _onGetUserVehicles(final GetUserVehiclesListEvent event,
      final Emitter<VehicleState> emit) async {
    await _updateVehicleList(emit);
  }

  Future<void> _registerUserVehicles(final RegisterVehicleEvent event,
      final Emitter<VehicleState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await _applicationService.registerUserVehicle(VehicleModel(
      null,
      event.viewModel.type,
      event.viewModel.licensePlate,
      event.viewModel.model,
    )).then((value) async =>
    await _updateVehicleList(emit));

    emit(state.copyWith(status: Status.success));

  }

  Future<void> _updateUserVehicles(final UpdateVehicleEvent event,
      final Emitter<VehicleState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await _applicationService.updateUserVehicle(VehicleModel(
      int.tryParse(event.viewModel.uuid),
      event.viewModel.type,
      event.viewModel.licensePlate,
      event.viewModel.model,
    )).then((value) async => await _updateVehicleList(emit));

    emit(state.copyWith(status: Status.success));

  }

  Future<void> _deleteUserVehicles(final DeleteVehicleEvent event,
      final Emitter<VehicleState> emit) async {
    emit(state.copyWith(status: Status.success));

    await _applicationService.deleteUserVehicle(event.uuid).then((
        value) async => await _updateVehicleList(emit)
    );

    emit(state.copyWith(status: Status.success));
  }

  Future<void> _updateVehicleList(final Emitter<VehicleState> emit) async {
    final List<VehicleModel> modelList = await _applicationService
        .findUserVehicles();


    final list = modelList.where((e) =>
    e.uuid != null && e.model != null && e.licensePlate != null &&
        e.type != null).map(
          (e) {
        return VehicleViewModel(
            e.type!, e.licensePlate!, e.model!, e.uuid.toString());
      },
    ).toList();

    emit(state.copyWith(usersVehicles: list, status: Status.success));
  }
}
