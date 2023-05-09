import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class ParkScreen extends StatefulWidget {
  const ParkScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ParkScreenState();
}

class _ParkScreenState extends State<ParkScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterMap(options: MapOptions()),
      ],
    );
  }
}
