import 'package:flutter/material.dart';

typedef TimeValueChanged = void Function(TimeOfDay value);

class TimePicker extends StatefulWidget {
  final String label;
  final TimeOfDay value;
  final TimeValueChanged onChanged;

  const TimePicker({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay(
      hour: widget.value.hour,
      minute: widget.value.minute,
    ).format(context);

    return ListTile(
      title: Text(widget.label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(time)],
      ),
      onTap: () async {
        final v = await _showTimePicker(context, widget.value);

        if (v == null) {
          return;
        } else {
          widget.onChanged(v);
        }
      },
    );
  }
}

Future<TimeOfDay?> _showTimePicker(
  BuildContext context,
  TimeOfDay initialTime,
) async {
  return await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
}
