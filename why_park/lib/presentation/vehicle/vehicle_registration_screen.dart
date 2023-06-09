import 'package:flutter/material.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'dumb_widgets/image_box.dart';

enum Preferential { yes, no }

class VehicleRegistrationScreen extends StatefulWidget {
  const VehicleRegistrationScreen(this._presenter, this._viewModel,
      [final Key? key])
      : super(key: key);

  final VehiclePresenter _presenter;
  final VehicleViewModel? _viewModel;

  @override
  State<StatefulWidget> createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistrationScreen> {
  static const _carImagePath = 'assets/images/img_car.png';
  static const _motorcycleImagePath = 'assets/images/img_motorcycle.png';

  bool _isEditing() => widget._viewModel != null;

  bool _resolveCarVehicleType() {
    return _isEditing() ? widget._viewModel!.type == VehicleType.car : false;
  }

  bool _resolveBikeVehicleType() {
    return _isEditing() ? widget._viewModel!.type == VehicleType.bike : false;
  }

  @override
  void initState() {
    _isEditing()
        ? _licensePlateController.text = widget._viewModel!.licensePlate
        : '';
    _isEditing() ? _modelController.text = widget._viewModel!.model : '';
    super.initState();
  }

  late bool _isFirstSelected = _resolveCarVehicleType();
  late bool _isSecondSelected = _resolveBikeVehicleType();

  Preferential _preferential = Preferential.no;

  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final FocusNode _modelFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31.0, 0.0, 31.0, 0.0),
        child: Column(
          children: [
            SizedBox(height: mediaQueryHeight * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFirstSelected = true;
                      _isSecondSelected = false;
                    });
                  },
                  child: ImageBox(_carImagePath, _isFirstSelected),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFirstSelected = false;
                      _isSecondSelected = true;
                    });
                  },
                  child: ImageBox(_motorcycleImagePath, _isSecondSelected),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _licensePlateController,
              onFieldSubmitted: (_) => _modelFocusNode.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Placa',
                filled: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _modelController,
              focusNode: _modelFocusNode,
              decoration: const InputDecoration(
                labelText: 'Modelo',
                filled: true,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Possui necessidades especiais?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                RadioListTile(
                  activeColor: const Color(0xFFF27D16),
                  controlAffinity: ListTileControlAffinity.platform,
                  title: const Text('Não'),
                  value: Preferential.no,
                  groupValue: _preferential,
                  onChanged: (value) {
                    setState(() {
                      _preferential = value!;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: const Color(0xFFF27D16),
                  controlAffinity: ListTileControlAffinity.platform,
                  title: const Text('Sim'),
                  value: Preferential.yes,
                  groupValue: _preferential,
                  onChanged: (value) {
                    setState(() {
                      _preferential = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: mediaQueryHeight * 0.05),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _isEditing()
                              ? widget._presenter.add(UpdateVehicleEvent(
                                  VehicleViewModel(
                                      _isFirstSelected
                                          ? VehicleType.car
                                          : VehicleType.bike,
                                      _licensePlateController.text,
                                      _modelController.value.text,
                                      widget._viewModel!.uuid)))
                              : widget._presenter.add(RegisterVehicleEvent(
                                  VehicleViewModel(
                                      _isFirstSelected
                                          ? VehicleType.car
                                          : VehicleType.bike,
                                      _licensePlateController.text,
                                      _modelController.value.text,
                                      _licensePlateController.text)));
                          widget._presenter.add(GetUserVehiclesListEvent());
                          Navigator.pop(context);
                        },
                        child: Text(
                          _isEditing() ? 'Atualizar' : 'Cadastrar',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
