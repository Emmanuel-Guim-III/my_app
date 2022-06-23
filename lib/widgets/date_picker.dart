import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_app/data/constants.dart';

typedef DateValueChanged = void Function(DateTime value);

class DatePicker extends StatefulWidget {
  final String label;
  final DateTime value;
  final DateValueChanged onChanged;

  const DatePicker({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMd().format(widget.value);

    return ListTile(
      title: Text(widget.label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(date)],
      ),
      onTap: () async {
        final v = await _showDatePicker(context, widget.value);

        if (v == null) {
          return;
        } else {
          widget.onChanged(v);
        }
      },
    );
  }
}

Future<DateTime?> _showDatePicker(
  BuildContext context,
  DateTime selectedDate,
) async {
  final firstDate =
      selectedDate.add(const Duration(days: -(numOfDaysInAYear * 10)));
  final lastDate =
      selectedDate.add(const Duration(days: numOfDaysInAYear * 10));

  return await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );
}
