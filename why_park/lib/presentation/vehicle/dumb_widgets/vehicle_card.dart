import 'package:flutter/material.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';

class VehicleCard extends StatelessWidget {
  VehicleCard(this._vehicleViewModel, [Key? key]) : super(key: key);

  final VehicleViewModel _vehicleViewModel;
  static const _carImagePath = 'assets/images/img_car.png';
  static const _motorcycleImagePath = 'assets/images/img_motorcycle.png';

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery
        .of(context)
        .size
        .height;
    final mediaQueryWidth = MediaQuery
        .of(context)
        .size
        .width;
    final bottom = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return InkWell(
      onLongPress: () => print('long press'),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            _vehicleViewModel.type == VehicleType.car
                ? _carImagePath
                : _motorcycleImagePath,
            height: mediaQueryHeight * 0.2,
            width: 90,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    border: Border.all(),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("Modelo: ${_vehicleViewModel.model}"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF27D16),
                    border: Border.all(),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("Placa: ${_vehicleViewModel.licensePlate}"),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
