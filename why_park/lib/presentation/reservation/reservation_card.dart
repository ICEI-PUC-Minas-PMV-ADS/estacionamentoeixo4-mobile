import 'package:flutter/material.dart';
import 'package:why_park/presentation/reservation/view_model/reservation_view_model.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard(this._viewModel, [Key? key]) : super(key: key);

  final ReservationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    'Nº da reserva: ${_viewModel.id}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Data: ${_viewModel.date}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFF27D16),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Duração: ${_viewModel.duration}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
