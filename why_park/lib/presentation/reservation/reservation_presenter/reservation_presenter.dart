import 'package:bloc/bloc.dart';
import 'package:why_park/application/reservation/reservation_application_service.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_events.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_state.dart';
import 'package:why_park/presentation/reservation/view_model/reservation_view_model.dart';

import '../../../application/reservation/model/reservation_model.dart';
import '../../../application/vehicle/model/vehicle_model.dart';
import '../../../utils/state_status.dart';
import '../../vehicle/model/vehicle_view_model.dart';

class ReservationPresenter extends Bloc<ReservationEvents, ReservationState> {
  ReservationPresenter(this._applicationService,
      this._vehicleQueryApplicationService, this._sessionStorage)
      : super(const ReservationState()) {
    on<ReservationSubmitted>(_onReservationSubmitted);
    on<ReservationFieldsChangedEvent>(_onFieldChangedEvent);
    on<GetUserVehiclesListEvent>(_onGetUserVehicles);
    on<GetReservationsList>(_onGetReservations);
    on<CancelReservation>(_onCancelReservations);
  }

  final ReservationApplicationService _applicationService;
  final VehicleQueryApplicationService _vehicleQueryApplicationService;
  final SessionStorage _sessionStorage;

  _onFieldChangedEvent(final ReservationFieldsChangedEvent event,
      final Emitter<ReservationState> emit) {
    switch (event.label) {
      case "year":
        emit(state.copyWith(year: event.value, status: Status.initial));
        break;
      case "month":
        emit(state.copyWith(month: event.value, status: Status.initial));
        break;
      case "day":
        emit(state.copyWith(day: event.value, status: Status.initial));
        break;
      case "hour":
        emit(state.copyWith(hour: event.value, status: Status.initial));
        break;
      case "minute":
        emit(state.copyWith(minute: event.value, status: Status.initial));
        break;
      case "duration":
        emit(state.copyWith(duration: event.value, status: Status.initial));
        break;
      case "vehicleId":
        emit(state.copyWith(vehicleId: event.value, status: Status.initial));
        break;
    }
  }

  Future<void> _onGetUserVehicles(final GetUserVehiclesListEvent event,
      final Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final List<VehicleModel> modelList =
        await _vehicleQueryApplicationService.findUserVehicles();

    final list = modelList
        .where((e) =>
            e.uuid != null &&
            e.model != null &&
            e.licensePlate != null &&
            e.type != null)
        .map(
      (e) {
        return VehicleViewModel(
            e.type!, e.licensePlate!, e.model!, e.uuid.toString());
      },
    ).toList();

    emit(state.copyWith(
        vehicleList: list,
        status: Status.initial,
        vehicleId: list.first.licensePlate));
  }

  Future<void> _onReservationSubmitted(
    final ReservationSubmitted event,
    final Emitter<ReservationState> emit,
  ) async {
    try {
      final String date = DateTime.utc(
        int.parse(state.year),
        int.parse(state.month),
        int.parse(state.day),
        int.parse(state.hour),
        int.parse(state.minute),
        DateTime.now().second,
        DateTime.now().millisecond,
        DateTime.now().microsecond,
      ).toIso8601String();

      final String id = await _sessionStorage.retrieveId() ?? '';

      ReservationModel model = ReservationModel(
          int.parse(id),
          int.parse(state.duration),
          date,
          int.parse(event.parkId),
          int.parse(state.vehicleList
              .firstWhere((element) => element.licensePlate == state.vehicleId)
              .uuid),
          int.parse(id));
      _applicationService.registerReservation(model);
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onGetReservations(final GetReservationsList event,
      final Emitter<ReservationState> emit) async {
    await _getReservation(emit);
  }

  Future<void> _onCancelReservations(final CancelReservation event,
      final Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await _applicationService.cancelReservation(int.parse(event.uuid));

    await _getReservation(emit);
  }

  Future<void> _getReservation(final Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final List<ReservationModel> modelList =
        await _applicationService.getReservation();

    final list = modelList.where((e) => e.hour != null).map(
      (e) {
        return ReservationViewModel(
            e.id.toString(),
            '${DateTime.tryParse(e.hour)?.day}/${DateTime.tryParse(e.hour)?.month}/${DateTime.tryParse(e.hour)?.year}',
            e.duration.toString(),
            DateTime.tryParse(e.hour)!
                .add(Duration(hours: e.duration))
                .isBefore(DateTime.now()));
      },
    ).toList();

    emit(state.copyWith(reservationList: list, status: Status.initial));
  }
}
