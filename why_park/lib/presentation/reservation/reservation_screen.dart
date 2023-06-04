import 'package:flutter/material.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen(this._viewModel, [Key? key]) : super(key: key);

  final ParkViewModel _viewModel;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
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
                  children: const [
                    Text('Data da reserva: '),
                    DatePickerExample(restorationId: 'main'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Horário da reserva: '),
                    ScreenOne(),
                  ],
                ),
              ],
            ),
          ),
        ),
        OutlinedButton(
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xFFF27D16))),
          onPressed: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Reservar',
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  final TextEditingController _controller = TextEditingController();

  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
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
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selecionado: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
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
          child: Text(_selectedDate.value != null
              ? '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'
              : 'Selecione a data da reserva'),
        ),
      ),
    );
  }
}

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

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
          child: Text(_timeC.text),
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
      });
    }
  }
}
