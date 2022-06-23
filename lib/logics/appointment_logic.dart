import 'package:my_app/models/appointment_model.dart';
import 'package:my_app/services/appointment_service.dart';

abstract class AppointmentLogic {
  Future<int> createAppointment(AppointmentModel appointment);
  Future<List<AppointmentModel>> getAppointments();
  Future<int> updateAppointment(AppointmentModel appointment);
  Future<int> deleteAppointment(int id);
}

class AppointmentLogicImpl implements AppointmentLogic {
  final AppointmentService _appointmentService;

  AppointmentLogicImpl(
    this._appointmentService,
  );

  @override
  Future<int> createAppointment(AppointmentModel appointment) async {
    return await _appointmentService.createAppointment(appointment);
  }

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    return await _appointmentService.getAppointments();
  }

  @override
  Future<int> updateAppointment(AppointmentModel appointment) async {
    return await _appointmentService.updateAppointment(appointment);
  }

  @override
  Future<int> deleteAppointment(int id) async {
    return await _appointmentService.deleteAppointment(id);
  }
}
