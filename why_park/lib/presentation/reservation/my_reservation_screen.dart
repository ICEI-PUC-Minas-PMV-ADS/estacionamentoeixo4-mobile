import 'package:flutter/material.dart';
import 'package:why_park/presentation/reservation/reservation_card.dart';
import 'package:why_park/utils/reservation_mock.dart';

class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen([Key? key]) : super(key: key);

  @override
  State<MyReservationsScreen> createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
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
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
              child: ListView.separated(
                itemBuilder: (final BuildContext context, final int index) {
                  return ReservationCard(
                      ReservationMock.reservationViewModels[index]);
                },
                itemCount: ReservationMock.reservationViewModels.length,
                separatorBuilder:
                    (final BuildContext context, final int index) =>
                        const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
              child: ListView.separated(
                itemBuilder: (final BuildContext context, final int index) {
                  return ReservationCard(
                      ReservationMock.expiredReservationViewModels[index]);
                },
                itemCount: ReservationMock.expiredReservationViewModels.length,
                separatorBuilder:
                    (final BuildContext context, final int index) =>
                        const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
