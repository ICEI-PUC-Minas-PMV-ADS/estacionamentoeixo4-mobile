import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Bem-vindo!',
      style: TextStyle(color: Colors.white),
    ),
    Text(
      'Seus veículos aqui',
      style: TextStyle(color: Colors.white),
    ),
    Text(
      'Suas reservas recentes',
      style: TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
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
        selectedItemColor: const Color(0xFF5E5CE5),
        onTap: _onItemTapped,
      ),
    );
  }
}
