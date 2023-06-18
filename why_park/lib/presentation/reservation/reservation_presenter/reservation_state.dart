import 'package:equatable/equatable.dart';

import '../../../utils/state_status.dart';

class ReservationState extends Equatable {
  const ReservationState({
    this.date = '',
    this.duration = '',
    this.status = Status.initial,
  });

  final String date;
  final String duration;
  final Status status;

  ReservationState copyWith({
    String? date,
    String? duration,
    Status? status,
  }) {
    return ReservationState(
      date: date ?? this.date,
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, duration, status];
}