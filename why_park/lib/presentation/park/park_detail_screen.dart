import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:why_park/presentation/park/bottom_sheet_park_detail.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_events.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_presenter.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_state.dart';
import 'package:why_park/presentation/park/park_detail_screen_arguments.dart';

class ParkDetailScreen extends StatefulWidget {
  const ParkDetailScreen(this._presenter, this._arguments, [Key? key])
      : super(key: key);

  final ParkDetailPresenter _presenter;
  final ParkDetailScreenArguments _arguments;

  @override
  State<StatefulWidget> createState() => _ParkDetailScreenState();
}

class _ParkDetailScreenState extends State<ParkDetailScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = <Marker>{};

  final Set<Polyline> _polyline = <Polyline>{};
  int _polylineCounter = 1;

  @override
  void initState() {
    _setupMarkers();
    super.initState();
  }

  void _setupPolyline(List<PointLatLng> points, latitudeNeBounds,
      longitudeNeBounds, latitudeSwBounds, longitudeSwBounds) {
    final String polylineIdVal = 'polyline$_polylineCounter';
    setState(() {
      _polylineCounter++;

      _polyline.add(
        Polyline(
            polylineId: PolylineId(polylineIdVal),
            points: points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            width: 3,
            color: Colors.red),
      );

      _cameraUpdate(latitudeNeBounds, longitudeNeBounds, latitudeSwBounds,
          longitudeSwBounds);
    });
  }

  void _setupMarkers() {
    _markers.add(Marker(
      markerId: MarkerId(widget._arguments.viewModel.name),
      position: LatLng(widget._arguments.viewModel.latitude,
          widget._arguments.viewModel.longitude),
    ));
    _markers.add(Marker(
      markerId: const MarkerId('Personal location'),
      position: LatLng(widget._arguments.personalLatitude,
          widget._arguments.personalLongitude),
    ));
  }

  Future<void> _cameraUpdate(latitudeNeBounds, longitudeNeBounds,
      latitudeSwBounds, longitudeSwBounds) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
          southwest: LatLng(latitudeSwBounds, longitudeSwBounds),
          northeast: LatLng(
            latitudeNeBounds,
            longitudeNeBounds,
          )),
      25,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ParkDetailPresenter, ParkDetailState>(
        bloc: widget._presenter,
        listener: (context, state) {
          _setupPolyline(
            state.direction['polyline'],
            state.direction['bound_ne']['lat'],
            state.direction['bound_ne']['lng'],
            state.direction['bound_sw']['lat'],
            state.direction['bound_sw']['lng'],
          );
        },
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget._arguments.viewModel.latitude,
                widget._arguments.viewModel.longitude),
            zoom: 18.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _markers,
          polylines: _polyline,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
              heroTag: 'btn2',
              onPressed: () => widget._presenter.add(GetDirectionEvent(
                    widget._arguments.personalLatitude,
                    widget._arguments.viewModel.latitude,
                    widget._arguments.personalLongitude,
                    widget._arguments.viewModel.longitude,
                  )),
              child: const Icon(Icons.alt_route)),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: 'btn1',
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetParkDetail(
                      widget._presenter, widget._arguments.viewModel);
                },
              );
            },
            label: const Text('Reservar'),
            icon: const Icon(Icons.local_parking_outlined),
          ),
        ]),
      ),
    );
  }
}
