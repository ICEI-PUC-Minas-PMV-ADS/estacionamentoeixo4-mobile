import 'package:equatable/equatable.dart';
import 'package:why_park/presentation/reservation/view_model/reservation_view_model.dart';

import '../../../utils/state_status.dart';
import '../../vehicle/model/vehicle_view_model.dart';

class ReservationState extends Equatable {
  const ReservationState({
    this.year = '',
    this.month = '',
    this.day = '',
    this.hour = '',
    this.minute = '',
    this.duration = '',
    this.vehicleId = '',
    this.vehicleList = const [],
    this.reservationList = const [],
    this.status = Status.initial,
  });

  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final String duration;
  final String vehicleId;
  final List<VehicleViewModel> vehicleList;
  final List<ReservationViewModel> reservationList;

  final Status status;

  ReservationState copyWith({
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minute,
    String? duration,
    String? vehicleId,
    List<VehicleViewModel>? vehicleList,
    List<ReservationViewModel>? reservationList,
    Status? status,
  }) {
    return ReservationState(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      duration: duration ?? this.duration,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicleList: vehicleList ?? this.vehicleList,
      reservationList: reservationList ?? this.reservationList,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        year,
        month,
        day,
        hour,
        minute,
        duration,
        vehicleId,
        vehicleList,
        reservationList,
        status
      ];
}
