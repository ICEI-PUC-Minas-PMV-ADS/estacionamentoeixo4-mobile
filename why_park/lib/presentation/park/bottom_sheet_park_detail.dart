import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_presenter.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_state.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';

class BottomSheetParkDetail extends StatefulWidget {
  const BottomSheetParkDetail(Key? key, this._presenter, this._parkViewModel)
      : super(key: key);

  final ParkDetailPresenter _presenter;
  final ParkViewModel _parkViewModel;

  @override
  State<BottomSheetParkDetail> createState() => _BottomSheetParkDetailState();
}

class _BottomSheetParkDetailState extends State<BottomSheetParkDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkDetailPresenter, ParkDetailState>(
        bloc: widget._presenter,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30.0),
                  ),
                  child: Image.asset('assets/images/park.png'),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        widget._parkViewModel.name,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      Text(widget._parkViewModel.address),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Vagas totais disponíveis: '),
                                  Text(widget._parkViewModel.vacancies
                                      .toString())
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Vagas preferenciais disponíveis: '),
                                  Text(widget._parkViewModel.priorityVacancies
                                      .toString())
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xFFF27D16))),
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Prosseguir com a reserva',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
