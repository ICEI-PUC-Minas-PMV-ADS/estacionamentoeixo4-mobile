import 'package:flutter/material.dart';
import 'package:why_park/commons/commons_theme/theme_provider.dart';
import 'package:why_park/presentation/home/menu_drawer.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/park/park_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(final Key? key, this._parkPresenter) : super(key: key);

  final ParkPresenter _parkPresenter;

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
      ParkScreen(null, widget._parkPresenter),
      const Text('Seus veículos aqui'),
      const Text('Suas reservas recentes'),
    ];

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MenuDrawer(),
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
