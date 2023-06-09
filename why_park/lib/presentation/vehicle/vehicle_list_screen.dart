import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/vehicle/dumb_widgets/vehicle_card.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_events.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_state.dart';
import '../../routes_table.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen(this._presenter, [Key? key]) : super(key: key);

  final VehiclePresenter _presenter;

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._presenter.add(GetUserVehiclesListEvent());
    });
    super.initState();
  }

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

    return Scaffold(
      body: BlocBuilder<VehiclePresenter, VehicleState>(
        bloc: widget._presenter,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.usersVehicles.isEmpty
                ? Center(
              child: Text(
                  'Cadastre aqui seu primeiro veículo',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center
              ),
            )
                : Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
              child: ListView.separated(
                itemBuilder:
                    (final BuildContext context, final int index) {
                  return VehicleCard(
                      state.usersVehicles[index], widget._presenter);
                },
                itemCount: state.usersVehicles.length,
                separatorBuilder:
                    (final BuildContext context, final int index) =>
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: BlocListener<VehiclePresenter, VehicleState>(
        bloc: widget._presenter,
        listener: (context, state) {
          setState(() {
            widget._presenter.add(GetUserVehiclesListEvent());
          });
        },
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(RoutesTable.vehicle);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
