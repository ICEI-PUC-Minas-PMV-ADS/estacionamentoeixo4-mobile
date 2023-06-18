import 'package:flutter/material.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';
import 'package:why_park/presentation/home/menu_drawer.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/park/park_screen.dart';
import 'package:why_park/presentation/reservation/my_reservation_screen.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'package:why_park/presentation/vehicle/vehicle_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      this._parkPresenter, this._vehiclePresenter, this._sessionStorage,
      [final Key? key])
      : super(key: key);

  final ParkPresenter _parkPresenter;
  final VehiclePresenter _vehiclePresenter;
  final SessionStorage _sessionStorage;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = [
      ParkScreen(widget._parkPresenter),
      VehicleListScreen(widget._vehiclePresenter),
      MyReservationsScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MenuDrawer(widget._sessionStorage),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Veículos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Reservas',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
