import 'package:bloc/bloc.dart';
import 'package:why_park/application/reservation/reservation_application_service.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_events.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_state.dart';

import '../../../utils/state_status.dart';

class ReservationPresenter extends Bloc<ReservationEvents, ReservationState> {
  ReservationPresenter(this._applicationService) : super(const ReservationState()) {
    on<ReservationSubmitted>(_onReservationSubmitted);
    on<ReservationFieldsChangedEvent>(_onFieldChangedEvent);
  }

  final ReservationApplicationService _applicationService;

  _onFieldChangedEvent(final ReservationFieldsChangedEvent event,
      final Emitter<ReservationState> emit) {
    switch (event.label) {
      case "date":
        emit(state.copyWith(date: event.value, status: Status.initial));
        break;
      case "duration":
        emit(state.copyWith(duration: event.value, status: Status.initial));
        break;
    }
  }

  Future<void> _onReservationSubmitted(
    final ReservationSubmitted event,
    final Emitter<ReservationState> emit,
  ) async {
    //ReservationModel model = ReservationModel(duration, hour, parkId, vehicleId, clientId)
    //_applicationService.registerReservation(model);
  }
}
