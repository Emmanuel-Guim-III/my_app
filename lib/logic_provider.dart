import 'package:flutter/widgets.dart';
import 'package:my_app/logics/appointment_logic.dart';
import 'package:my_app/logics/item_logic.dart';

class LogicProvider extends InheritedWidget {
  final AppointmentLogic appointmentLogic;
  final ItemLogic itemLogic;

  const LogicProvider({
    Key? key,
    required this.appointmentLogic,
    required this.itemLogic,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static LogicProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LogicProvider>();
  }
}
