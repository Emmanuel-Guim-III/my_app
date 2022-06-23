import 'package:flutter/material.dart';
import 'package:my_app/logic_provider.dart';
import 'package:my_app/logics/appointment_logic.dart';
import 'package:my_app/logics/item_logic.dart';
import 'package:my_app/models/appointment_model.dart';
import 'package:my_app/models/item_model.dart';
import 'package:my_app/pages/create_appointment_form.dart';
import 'package:my_app/pages/appointments.dart';
import 'package:my_app/pages/inventory.dart';
import 'package:my_app/pages/item_adding_form.dart';
import 'package:my_app/services/appointment_service.dart';
import 'package:my_app/services/item_service.dart';
import 'package:my_app/page_routes.dart' as routes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final appointmentService = AppointmentServiceImpl();
  final itemService = ItemServiceImpl();

  final logicInjectedApp = LogicProvider(
    appointmentLogic: AppointmentLogicImpl(appointmentService),
    itemLogic: ItemLogicImpl(itemService),
    child: const MyApp(),
  );
  runApp(logicInjectedApp);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _getRoute,
    );
  }
}

Route<MaterialPageRoute> _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.appointment:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Appointments(),
        fullscreenDialog: true,
      );

    case routes.createAppointmentForm:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CreateAppointmentForm(
          appointment: settings.arguments as AppointmentModel,
        ),
        fullscreenDialog: true,
      );

    case routes.inventory:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Inventory(),
        fullscreenDialog: true,
      );

    case routes.itemAddingForm:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ItemAddingForm(
          item: settings.arguments as ItemModel,
        ),
        fullscreenDialog: true,
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
        fullscreenDialog: true,
      );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Appointments(),
    Inventory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_view_outlined),
            label: 'Inventory',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _handlePageChange,
      ),
    );
  }

  void _handlePageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
