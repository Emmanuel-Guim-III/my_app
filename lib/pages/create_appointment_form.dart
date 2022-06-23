import 'package:flutter/material.dart';
import 'package:my_app/logic_provider.dart';
import 'package:my_app/models/appointment_model.dart';
import 'package:my_app/page_routes.dart' as routes;
import 'package:my_app/utils/date_time.dart' as date_time;
import 'package:my_app/widgets/date_picker.dart';
import 'package:my_app/widgets/my_form_field.dart';
import 'package:my_app/widgets/time_picker.dart';

class CreateAppointmentForm extends StatefulWidget {
  final AppointmentModel? appointment;

  const CreateAppointmentForm({
    Key? key,
    this.appointment,
  }) : super(key: key);

  @override
  State<CreateAppointmentForm> createState() => _CreateAppointmentFormState();
}

class _CreateAppointmentFormState extends State<CreateAppointmentForm> {
  DateTime dateMem = date_time.getNowDateOnly();
  DateTime get _date => dateMem;
  set _date(DateTime v) => dateMem = v;

  TimeOfDay timeMem = date_time.getCurrentTime();
  TimeOfDay get _time => timeMem;
  set _time(TimeOfDay v) => timeMem = v;

  String purposeMem = '';
  String get _purpose => purposeMem;
  set _purpose(String v) => purposeMem = v;

  String expensesTotalMem = '';
  String get _totalExpenses => expensesTotalMem;
  set _totalExpenses(String v) => expensesTotalMem = v;

  @override
  void initState() {
    super.initState();

    _purpose = widget.appointment!.purpose;
    _date = widget.appointment!.date;
    _time = widget.appointment!.time;
    _totalExpenses = widget.appointment!.totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appointment'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: MyFormField.textField(
                label: 'Purpose',
                value: _purpose,
                onChanged: (v) {
                  setState(() {
                    _purpose = v;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: DatePicker(
                label: 'Date',
                value: _date,
                onChanged: (v) {
                  setState(() {
                    _date = v;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: TimePicker(
                label: 'Time',
                value: _time,
                onChanged: (v) {
                  setState(() {
                    _time = v;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: MyFormField.priceField(
                label: 'Total Expenses',
                value: _totalExpenses,
                onChanged: (v) {
                  setState(() {
                    _totalExpenses = v;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () => _saveAppointment(widget.appointment!.id),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveAppointment(int? id) async {
    final appt = AppointmentModel(
      id: id,
      purpose: _purpose,
      date: _date,
      time: _time,
      totalExpenses: _totalExpenses,
    );

    Navigator.popAndPushNamed(context, routes.appointment);

    final _appointmentLogic = LogicProvider.of(context)!.appointmentLogic;

    if (id == null) {
      await _appointmentLogic.createAppointment(appt);
    } else {
      await _appointmentLogic.updateAppointment(appt);
    }
  }
}
