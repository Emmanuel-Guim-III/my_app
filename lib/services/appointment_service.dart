import 'dart:async';

import 'package:my_app/db/db_config.dart';
import 'package:my_app/models/appointment_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppointmentService {
  Future<int> createAppointment(AppointmentModel appointment);
  Future<List<AppointmentModel>> getAppointments();
  Future<int> updateAppointment(AppointmentModel appointment);
  Future<int> deleteAppointment(int id);
}

class AppointmentServiceImpl implements AppointmentService {
  AppointmentServiceImpl();

  AppointmentServiceImpl._privateConstructor();
  static final AppointmentServiceImpl instance =
      AppointmentServiceImpl._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  @override
  Future<int> createAppointment(AppointmentModel appointment) async {
    final db = await instance.database;

    return await db.insert(
      'appointments',
      appointment.toMap(),
    );
  }

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> appointments =
        await db.query('appointments', orderBy: 'purpose');

    List<AppointmentModel> appointmentList = appointments.isNotEmpty
        ? appointments.map((a) => AppointmentModel.fromMap(a)).toList()
        : [];

    return appointmentList;
  }

  @override
  Future<int> updateAppointment(AppointmentModel appointment) async {
    final db = await instance.database;

    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  @override
  Future<int> deleteAppointment(int id) async {
    final db = await instance.database;

    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
