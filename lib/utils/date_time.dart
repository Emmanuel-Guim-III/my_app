import 'package:flutter/material.dart';

DateTime getDateTimeNow() {
  return DateTime.now();
}

DateTime getNowDateOnly() {
  final now = getDateTimeNow();

  return DateTime(now.year, now.month, now.day);
}

TimeOfDay getCurrentTime() {
  return TimeOfDay.now();
}

String cnvtTimeOfDayToString(TimeOfDay time) {
  return '${time.hour}:${time.minute}';
}

TimeOfDay cnvtStringToTimeOfDay(String time) {
  return TimeOfDay(
    hour: int.parse(time.split(":")[0]),
    minute: int.parse(time.split(":")[1]),
  );
}
