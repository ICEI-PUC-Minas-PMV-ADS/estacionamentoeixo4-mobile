import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_events.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_presenter.dart';
import 'package:why_park/presentation/reservation/reservation_presenter/reservation_state.dart';
import 'package:why_park/utils/state_status.dart';

import '../../routes_table.dart';
import '../../utils/custom_dialog.dart';
import '../vehicle/model/vehicle_view_model.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen(this._viewModel, this._presenter, [Key? key])
      : super(key: key);

  final ParkViewModel _viewModel;
  final ReservationPresenter _presenter;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._presenter.add(GetUserVehiclesListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
          child: Image.asset('assets/images/park.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<ReservationPresenter, ReservationState>(
          bloc: widget._presenter,
          builder: (final context, final state) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    Text(
                      widget._viewModel.name,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(widget._viewModel.address),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Data da reserva: '),
                        DatePicker('main', widget._presenter),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Horário da reserva: '),
                        ScreenOne(widget._presenter),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Duração da reserva: '),
                        QuantityCounterForm(widget._presenter),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Seleção de veículo: '),
                        VehicleDropdown(state.vehicleList, widget._presenter),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        BlocListener<ReservationPresenter, ReservationState>(
          bloc: widget._presenter,
          listener: (context, state) {
            if (state.status == Status.failure) {
              CustomDialog.showCustomDialog(
                context,
                state.status,
                'Erro na reserva',
                'Ocorreu um erro ao realizar a reserva. Verifique suas os dados e tente novamente.',
              );
            }
            if (state.status == Status.success) {
              // emergency workaround. Dont do this
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'Reserva realizada com sucesso!',
                  style: TextStyle(color: Colors.white),
                ),
              ));
            }
          },
          child: OutlinedButton(
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Color(0xFFF27D16))),
            onPressed: () => widget._presenter
                .add(ReservationSubmitted(widget._viewModel.id.toString())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Reservar',
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker(this.restorationId, this._presenter, [final Key? key])
      : super(key: key);

  final String? restorationId;
  final ReservationPresenter _presenter;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with RestorationMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    widget._presenter.add(ReservationFieldsChangedEvent(
        'year', DateTime.now().year.toString()));
    widget._presenter.add(ReservationFieldsChangedEvent(
        'month', DateTime.now().month.toString()));
    widget._presenter.add(ReservationFieldsChangedEvent(
        'day', DateTime.now().day.toString()));
    super.initState();
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2022),
          lastDate: DateTime(2024),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        widget._presenter.add(ReservationFieldsChangedEvent(
            'year', newSelectedDate.year.toString()));
        widget._presenter.add(ReservationFieldsChangedEvent(
            'month', newSelectedDate.month.toString()));
        widget._presenter.add(ReservationFieldsChangedEvent(
            'day', newSelectedDate.day.toString()));
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Selecionado: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
            style: const TextStyle(color: Colors.white),
          ),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _restorableDatePickerRouteFuture.present(),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            _selectedDate.value != null
                ? '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'
                : 'Selecione a data da reserva',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ScreenOne extends StatefulWidget {
  const ScreenOne(this._presenter, [final Key? key]) : super(key: key);

  final ReservationPresenter _presenter;

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final _dateC = TextEditingController();
  final _timeC = TextEditingController();

  ///Date
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);

  ///Time
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return buildUI(context);
  }

  Widget buildUI(BuildContext context) {
    return GestureDetector(
      onTap: () => displayTimePicker(context),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            _timeC.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        _dateC.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _timeC.text = "${time.hour}:${time.minute}";
        widget._presenter
            .add(ReservationFieldsChangedEvent('hour', time.hour.toString()));
        widget._presenter
            .add(ReservationFieldsChangedEvent('minute', time.hour.toString()));
      });
    }
  }
}

class QuantityCounterForm extends StatefulWidget {
  const QuantityCounterForm(this._presenter, [final Key? key])
      : super(key: key);

  final ReservationPresenter _presenter;

  @override
  _QuantityCounterFormState createState() => _QuantityCounterFormState();
}

class _QuantityCounterFormState extends State<QuantityCounterForm> {
  int _quantity = 0;

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        widget._presenter.add(
            ReservationFieldsChangedEvent('duration', _quantity.toString()));
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget._presenter
          .add(ReservationFieldsChangedEvent('duration', _quantity.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _decrementQuantity,
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 16),
        Text(
          '$_quantity',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 14),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: _incrementQuantity,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class VehicleDropdown extends StatefulWidget {
  const VehicleDropdown(this._list, this._presenter, [final Key? key])
      : super(key: key);

  final List<VehicleViewModel> _list;
  final ReservationPresenter _presenter;

  @override
  State<VehicleDropdown> createState() => _VehicleDropdownState();
}

class _VehicleDropdownState extends State<VehicleDropdown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationPresenter, ReservationState>(
        bloc: widget._presenter,
        builder: (context, state) {
          return state.vehicleList.isEmpty
              ? const CircularProgressIndicator()
              : DropdownButton<String>(
                  value: widget._list.first.licensePlate,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                      widget._presenter.add(ReservationFieldsChangedEvent(
                          'vehicleId', value.toString()));
                    });
                  },
                  items: widget._list
                      .map<DropdownMenuItem<String>>((VehicleViewModel value) {
                    return DropdownMenuItem<String>(
                      value: value.licensePlate,
                      child: Text(value.licensePlate),
                    );
                  }).toList(),
                );
        });
  }
}
