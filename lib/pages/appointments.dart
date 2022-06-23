import 'package:flutter/material.dart';
import 'package:my_app/logic_provider.dart';
import 'package:my_app/logics/appointment_logic.dart';
import 'package:my_app/models/appointment_model.dart';
import 'package:my_app/page_routes.dart' as routes;
import 'package:my_app/utils/date_time.dart' as date_time;

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  late AppointmentLogic _appointmentLogic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appointmentLogic = LogicProvider.of(context)!.appointmentLogic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: FutureBuilder<List<AppointmentModel>>(
                  future: _appointmentLogic.getAppointments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AppointmentModel>> appointments) {
                    if (!appointments.hasData) {
                      return const Center(child: Text('Loading...'));
                    }

                    return appointments.data!.isEmpty
                        ? const Center(
                            child: Text('No Appointment yet!'),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Purpose')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Time')),
                                DataColumn(label: Text('Total of Expenses')),
                              ],
                              rows: _buildDataRows(appointments),
                              showCheckboxColumn: false,
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAppointmentAddingForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<DataRow> _buildDataRows(
    AsyncSnapshot<List<AppointmentModel>> appointments,
  ) {
    return appointments.data!.map(
      (appointment) {
        final appt = appointment.formatProps(context);

        return DataRow(
          cells: [
            DataCell(
              Text(appt.purpose),
              onLongPress: () {
                _showDeleteConfirmationDialog(appointment);
              },
            ),
            DataCell(Text(appt.date)),
            DataCell(Text(appt.time)),
            DataCell(Text(appt.totalExpenses)),
          ],
          onSelectChanged: (bool? isSelected) {
            _showAppointmentUpdatingForm(appointment);
          },
        );
      },
    ).toList();
  }

  void _showAppointmentAddingForm() {
    final appt = AppointmentModel(
      purpose: '',
      date: date_time.getNowDateOnly(),
      time: date_time.getCurrentTime(),
      totalExpenses: '',
    );

    Navigator.pushNamed(
      context,
      routes.createAppointmentForm,
      arguments: appt,
    );
  }

  void _deleteAppointment(int id) {
    _appointmentLogic.deleteAppointment(id);
    setState(() {});
  }

  void _showDeleteConfirmationDialog(AppointmentModel appt) {
    final noBtn = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('No'),
    );

    final yesBtn = TextButton(
      onPressed: () {
        _deleteAppointment(appt.id ?? 0);
      },
      child: const Text('Yes'),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete "${appt.purpose}" appointment?'),
          content: const Text(
            'Doing so will permanently remove it from your record.',
          ),
          contentPadding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
          actions: [noBtn, yesBtn],
        );
      },
    );
  }

  void _showAppointmentUpdatingForm(AppointmentModel appt) {
    Navigator.pushNamed(
      context,
      routes.createAppointmentForm,
      arguments: appt,
    );
  }
}
