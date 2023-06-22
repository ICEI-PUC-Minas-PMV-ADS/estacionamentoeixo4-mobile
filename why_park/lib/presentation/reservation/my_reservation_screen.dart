import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/reservation/reservation_card.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_events.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_presenter.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_state.dart';
import 'package:why_park/presentation/reservation/view_model/reservation_view_model.dart';
import 'package:why_park/utils/reservation_mock.dart';

import '../../utils/state_status.dart';

class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen(this._presenter, [Key? key]) : super(key: key);

  final ReservationPresenter _presenter;

  @override
  State<MyReservationsScreen> createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._presenter.add(GetReservationsList());
    });
    super.initState();
  }

  Future<void> _showCustomDialog(
      final BuildContext context, final String uuid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (final BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          content: Text(
            'Deseja cancelar sua reserva?',
            style: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: OutlinedButton(
                      onPressed: () async {
                        widget._presenter.add(CancelReservation(uuid));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Column(
            children: const <Widget>[
              TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Minhas Reservas"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Histórico"),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<ReservationPresenter, ReservationState>(
            bloc: widget._presenter,
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return state.reservationList.isEmpty
                    ? Center(
                        child: Text(
                          'Aqui aparecerão suas primeiras reservas',
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center
                        ),
                      )
                    : TabBarView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
                            child: ListView.separated(
                              itemBuilder: (final BuildContext context,
                                  final int index) {
                                return InkWell(
                                  onLongPress: () => _showCustomDialog(
                                      context, state.reservationList[index].id),
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ReservationCard(state.reservationList
                                      .where((ReservationViewModel element) =>
                                          element.hasExpired == false)
                                      .toList()[index]),
                                );
                              },
                              itemCount: state.reservationList
                                  .where((ReservationViewModel element) =>
                                      element.hasExpired == false)
                                  .toList()
                                  .length,
                              separatorBuilder: (final BuildContext context,
                                      final int index) =>
                                  const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
                            child: ListView.separated(
                              itemBuilder: (final BuildContext context,
                                  final int index) {
                                return ReservationCard(state.reservationList
                                    .where((ReservationViewModel element) =>
                                        element.hasExpired == true)
                                    .toList()[index]);
                              },
                              itemCount: state.reservationList
                                  .where((ReservationViewModel element) =>
                                      element.hasExpired == true)
                                  .toList()
                                  .length,
                              separatorBuilder: (final BuildContext context,
                                      final int index) =>
                                  const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(),
                              ),
                            ),
                          )
                        ],
                      );
              }
            }),
      ),
    );
  }
}
