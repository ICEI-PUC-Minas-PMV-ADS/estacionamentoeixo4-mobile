import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';

class VehicleCard extends StatelessWidget {
  final VehicleViewModel _vehicleViewModel;
  static const _carImagePath = 'assets/images/img_car.png';
  static const _motorcycleImagePath = 'assets/images/img_motorcycle.png';

  const VehicleCard(this._vehicleViewModel);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF474545),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 20,
          ),
          Image.asset(
            _vehicleViewModel.type == VehicleType.car
                ? _carImagePath
                : _motorcycleImagePath,
            height: mediaQueryHeight * 0.25,
            width: 90,
          ),
          SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Modelo: ${_vehicleViewModel.model}",
                style: TextStyle(fontSize: 15),
              ),
              Text("Placa: ${_vehicleViewModel.licensePlate}")
            ],
          ),
        ]),
        onTap: () => print("ok"),
      ),
    );
  }
}
