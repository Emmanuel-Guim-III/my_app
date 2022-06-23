import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/utils/date_time.dart' as date_time;

class AppointmentModel {
  final int? id;
  final String purpose;
  final DateTime date;
  final TimeOfDay time;
  final String totalExpenses;

  const AppointmentModel({
    this.id,
    required this.purpose,
    required this.date,
    required this.time,
    required this.totalExpenses,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        purpose: json['purpose'],
        date: DateTime.parse(json['date']),
        time: date_time.cnvtStringToTimeOfDay(json['time']),
        totalExpenses: json['totalExpenses'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purpose': purpose,
      'date': date.toString(),
      'time': date_time.cnvtTimeOfDayToString(time),
      'totalExpenses': totalExpenses,
    };
  }

  @override
  String toString() {
    return '''
      Appointment{
        id: $id, 
        purpose: $purpose, 
        date: $date, 
        time: $time, 
        totalExpenses: $totalExpenses
      }
    ''';
  }

  AppointmentResult formatProps(BuildContext context) {
    return AppointmentResult(
      id: id.toString(),
      purpose: purpose,
      date: DateFormat('MMM dd, yyyy').format(date),
      time: time.format(context).toString(),
      totalExpenses: double.parse(totalExpenses).toStringAsFixed(2),
    );
  }
}

class AppointmentResult {
  final String id;
  final String purpose;
  final String date;
  final String time;
  final String totalExpenses;

  const AppointmentResult({
    required this.id,
    required this.purpose,
    required this.date,
    required this.time,
    required this.totalExpenses,
  });
}
