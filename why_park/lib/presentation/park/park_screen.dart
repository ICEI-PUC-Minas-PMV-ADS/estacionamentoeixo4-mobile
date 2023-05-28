import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:why_park/presentation/park/bottom_sheet_nearest_parks.dart';
import 'package:why_park/presentation/park/park_presenter/park_events.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/park/park_presenter/park_state.dart';

class ParkScreen extends StatefulWidget {
  const ParkScreen(final Key? key, this._presenter) : super(key: key);

  final ParkPresenter _presenter;

  @override
  State<StatefulWidget> createState() => _ParkScreenState();
}

class _ParkScreenState extends State<ParkScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    widget._presenter.add(GetPositionEvent());
    super.initState();
  }

  Future<void> _cameraUpdate(final double latitude, longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 18.4746,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ParkPresenter, ParkState>(
          bloc: widget._presenter,
          builder: (context, state) {
            return BlocListener<ParkPresenter, ParkState>(
              bloc: widget._presenter,
              listenWhen: (current, previous) =>
                  current.longitude != previous.longitude ||
                  current.latitude != previous.latitude,
              listener: (BuildContext context, state) {
                _cameraUpdate(state.latitude, state.longitude);
              },
              child: GoogleMap(
                mapType: MapType.satellite,
                initialCameraPosition: CameraPosition(
                  target: LatLng(state.latitude, state.longitude),
                  zoom: 18.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(state.latitude, state.longitude))
                },
              ),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () => widget._presenter.add(GetPositionEvent()),
                child: const Icon(
                  Icons.my_location,
                  size: 28,
                )),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
              heroTag: 'btn1',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: BottomSheetNearestParks(null, widget._presenter),
                      ),
                    );
                  },
                );
              },
              label: const Text('       Buscar \nEstacionamentos'),
              icon: const Icon(Icons.local_parking_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
