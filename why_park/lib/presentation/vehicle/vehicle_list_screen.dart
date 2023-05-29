import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/vehicle/dumb_widgets/vehicle_card.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_state.dart';
import '../../routes_table.dart';
import 'model/vehicle_view_model.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen(this._presenter, [Key? key]) : super(key: key);

  final VehiclePresenter _presenter;

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    widget._presenter.add(GetUserVehiclesListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: BlocBuilder<VehiclePresenter, VehicleState>(
        bloc: widget._presenter,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
            child: ListView.separated(
              itemBuilder: (final BuildContext context, final int index) {
                return VehicleCard(state.usersVehicles[index], widget._presenter);
              },
              itemCount: state.usersVehicles.length,
              separatorBuilder: (final BuildContext context, final int index) =>
                  const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(RoutesTable.vehicle);
          widget._presenter.add(GetUserVehiclesListEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
