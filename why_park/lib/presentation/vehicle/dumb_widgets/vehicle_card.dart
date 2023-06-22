import 'package:flutter/material.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';

import '../../../routes_table.dart';

class VehicleCard extends StatelessWidget {
  VehicleCard(this._vehicleViewModel, this._presenter, [Key? key]) : super(key: key);

  final VehicleViewModel _vehicleViewModel;
  final VehiclePresenter _presenter;
  static const _carImagePath = 'assets/images/img_car.png';
  static const _motorcycleImagePath = 'assets/images/img_motorcycle.png';

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    Future<void> _showCustomDialog(final BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (final BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: Text(
              'Aqui você pode editar ou excluir o seu veículo ${_vehicleViewModel.model} de placa ${_vehicleViewModel.licensePlate}',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
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
                          await Navigator.of(context).pushNamed(RoutesTable.vehicle, arguments: _vehicleViewModel);
                          _presenter.add(GetUserVehiclesListEvent());
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Editar',
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _presenter.add(DeleteVehicleEvent(_vehicleViewModel.uuid));
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.delete, color: Colors.deepOrange,),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onLongPress: () => _showCustomDialog(context),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("Modelo: ${_vehicleViewModel.model}", style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF27D16),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("Placa: ${_vehicleViewModel.licensePlate}", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
