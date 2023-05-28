import 'package:bloc/bloc.dart';
import 'package:why_park/application/park/park_detail_application_service.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_events.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_state.dart';

class ParkDetailPresenter extends Bloc<ParkDetailEvents, ParkDetailState> {
  ParkDetailPresenter(this._applicationService)
      : super(const ParkDetailState()) {
    on<GetDirectionEvent>(_getDirection);
  }

  final ParkDetailApplicationService _applicationService;

  Future<void> _getDirection(final GetDirectionEvent event,
      final Emitter<ParkDetailState> emit) async {
    final origin = '${event.originLatitude},${event.originLongitude}';
    final destination =
        '${event.destinationLatitude},${event.destinationLongitude}';
    final directions =
        await _applicationService.getDirections(origin, destination);

    emit(state.copyWith(
      direction: directions,
      status: Status.success,
    ));
  }
}
