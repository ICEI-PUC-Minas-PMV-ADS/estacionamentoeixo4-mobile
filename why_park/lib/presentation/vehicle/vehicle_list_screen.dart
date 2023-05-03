import 'package:flutter/material.dart';
import 'package:why_park/presentation/vehicle/dumb_widgets/vehicle_card.dart';
import 'model/vehicle_view_model.dart';

class VehicleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final List<VehicleViewModel> list = [
      VehicleViewModel(VehicleType.car, "PLZ-2345", "Honda City"),
      VehicleViewModel(VehicleType.bike, "PXJ-2320", "yamaha R1"),
      VehicleViewModel(VehicleType.car, "PXJ-2320", "Honda City"),
      VehicleViewModel(VehicleType.car, "PXJ-2320", "Honda City")
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(31.0, 31.0, 31.0, bottom),
        child: ListView.separated(
            itemBuilder: (final BuildContext context, final int index) {
              return VehicleCard(list[index]);
            },
            itemCount: list.length,
            separatorBuilder: (final BuildContext context, final int index) =>
                Divider(
                  color: Colors.transparent,
                )),
      ),
    );
  }
}
