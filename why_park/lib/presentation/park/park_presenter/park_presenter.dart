import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:why_park/application/park/model/park_model.dart';
import 'package:why_park/application/park/park_query_application_service.dart';
import 'package:why_park/presentation/park/park_presenter/park_events.dart';
import 'package:why_park/presentation/park/park_presenter/park_state.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';
import 'package:why_park/utils/parks_mock.dart';

import '../../../commons/commons_geolocator/user_geolocator_provider.dart';
import '../../../commons/commons_theme/theme_provider.dart';

class ParkPresenter extends Bloc<ParkEvents, ParkState> {
  ParkPresenter(this._applicationService) : super(const ParkState()) {
    on<GetPositionEvent>(_onDeterminePosition);
    on<GetNearestParks>(_onGetNearestParks);
    on<SearchParkByAddressEvent>(_findParks);
  }

  static const int _toKilometersDivisor = 1000;

  final ParkQueryApplicationService _applicationService;

  Future<void> _onDeterminePosition(
    final GetPositionEvent event,
    final Emitter<ParkState> emit,
  ) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();

    DarkThemeProvider themeChangeProvider = DarkThemeProvider();
    UserGeolocatorProvider userGeolocatorProvider = UserGeolocatorProvider();

    userGeolocatorProvider.location =
        LatLng(position.latitude, position.latitude);

    emit(
      state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        status: Status.success,
      ),
    );
  }

  Future<void> _onGetNearestParks(
    final GetNearestParks event,
    final Emitter<ParkState> emit,
  ) async {
    final List<ParkViewModel> list = ParksMock.parkingLots.map(
      (e) {
        return ParkViewModel(
            e.name,
            e.address,
            _calculateDistance(
                  state.latitude,
                  state.longitude,
                  e.latitude,
                  e.longitude,
                ) /
                _toKilometersDivisor,
            e.latitude,
            e.longitude,
            e.rating,
            e.pricePerHour,
            e.priorityVacancies,
            e.vacancies);
      },
    ).toList();

    list.sort((a, b) => a.distanceForMe.compareTo(b.distanceForMe));

    emit(state.copyWith(nearestParks: list, status: Status.success));
  }

  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<void> _findParks(
    final SearchParkByAddressEvent event,
    final Emitter<ParkState> emit,
  ) async {
    // TODO: create appService
    final List<ParkModel> list = ParksMock.parkingLots
        .where((element) => element.address.contains(event.value))
        .toList();
    final filteredList = list.map(
      (e) {
        // TODO: add converter
        return ParkViewModel(
            e.name,
            e.address,
            _calculateDistance(
                  state.latitude,
                  state.longitude,
                  e.latitude,
                  e.longitude,
                ) /
                _toKilometersDivisor,
            e.latitude,
            e.longitude,
            e.rating,
            e.pricePerHour,
            e.priorityVacancies,
            e.vacancies);
      },
    ).toList();

    emit(state.copyWith(nearestParks: filteredList, status: Status.success));
  }
}
