import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/park/park_detail_screen_arguments.dart';
import 'package:why_park/presentation/park/park_presenter/park_events.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/park/park_presenter/park_state.dart';
import 'package:why_park/routes_table.dart';

class BottomSheetNearestParks extends StatefulWidget {
  const BottomSheetNearestParks(this._presenter, [Key? key]) : super(key: key);

  final ParkPresenter _presenter;

  @override
  State<BottomSheetNearestParks> createState() =>
      _BottomSheetNearestParksState();
}

class _BottomSheetNearestParksState extends State<BottomSheetNearestParks> {
  @override
  void initState() {
    widget._presenter.add(GetNearestParks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ParkPresenter, ParkState>(
      bloc: widget._presenter,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (value) =>
                      widget._presenter.add(SearchParkByAddressEvent(value)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Endereço de destino",
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on),
                    Text(
                      "Estacionamentos mais próximos de você:",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(
                            RoutesTable.parkDetail,
                            arguments: ParkDetailScreenArguments(
                              state.nearestParks[index],
                              state.latitude,
                              state.longitude,
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _resolveFadeText(
                                          state.nearestParks[index].name),
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.nearestParks[index].address
                                          .split('-')
                                          .first,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    Text(
                                      state.nearestParks[index].address
                                          .split('- ')
                                          .last,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber),
                                        Text(state.nearestParks[index].rating
                                            .toString())
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            'A ${state.nearestParks[index].distanceForMe.truncateToDouble()} km'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF27D16),
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            'R\$ ${state.nearestParks[index].pricePerHour}/h'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.nearestParks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _resolveFadeText(String text) {
    String normalizedText = '';
    if (text.length > 17) {
      normalizedText = text.split(' ').join('\n');
      return normalizedText;
    }
    return text;
  }
}
