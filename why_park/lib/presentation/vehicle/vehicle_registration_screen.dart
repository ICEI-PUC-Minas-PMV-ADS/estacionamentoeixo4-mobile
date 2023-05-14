import 'package:flutter/material.dart';
import 'dumb_widgets/image_box.dart';

enum Preferential { yes, no }

class VehicleRegistrationScreen extends StatefulWidget {
  const VehicleRegistrationScreen(final Key? key) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistrationScreen> {
  static const _carImagePath = 'assets/images/img_car.png';
  static const _motorcycleImagePath = 'assets/images/img_motorcycle.png';

  bool _isFirstSelected = false;
  bool _isSecondSelected = false;

  Preferential _preferential = Preferential.no;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(31.0, 0.0, 31.0, bottom),
        child: SingleChildScrollView(
          reverse: true,
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
                height: 60,
              ),
              TextFormField(
                onChanged: (value) => print(value),
                // onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                decoration: InputDecoration(
                    hintText: 'Placa',
                    hintStyle: const TextStyle(color: Color(0xFF959595)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color(0xFF262626)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) => print(value),
                // onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                decoration: InputDecoration(
                    hintText: 'Modelo',
                    hintStyle: const TextStyle(color: Color(0xFF959595)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color(0xFF262626)),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Possui necessidade especial?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey[500]),
                    child: RadioListTile(
                      activeColor: const Color(0xFFF27D16),
                      controlAffinity: ListTileControlAffinity.platform,
                      title: const Text(
                        'Não',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: Preferential.no,
                      groupValue: _preferential,
                      onChanged: (value) {
                        setState(() {
                          _preferential = value!;
                        });
                      },
                    ),
                  ),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey[500]),
                    child: RadioListTile(
                      activeColor: const Color(0xFFF27D16),
                      controlAffinity: ListTileControlAffinity.platform,
                      title: const Text(
                        'Sim',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: Preferential.yes,
                      groupValue: _preferential,
                      onChanged: (value) {
                        setState(() {
                          _preferential = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQueryHeight * 0.15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFFFFFFFF))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                              color: Color(0xFF5E5CE5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mediaQueryWidth * 0.05,
                      ),
                      const Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF5E5CE5))),
                          onPressed: null,
                          child: Text(
                            'Cadastrar',
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
      ),
    );
  }
}
