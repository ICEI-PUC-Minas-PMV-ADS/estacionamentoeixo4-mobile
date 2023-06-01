import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen([Key? key]) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: const TabBarView(
          children: <Widget>[
            Center(child: Text("Reservas")),
            Center(child: Text("Histórico"))
          ],
        ),
      ),
    );
  }
}
