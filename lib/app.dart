// import 'package:flutter/material.dart';
// import 'package:my_app/pages/create_appointment.dart';
// import 'package:my_app/pages/health_care_appointment.dart';
// import 'package:my_app/widgets/menu_drawer.dart';
// import 'package:my_app/page_routes.dart' as routes;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: routes.root,
//       onGenerateRoute: _getRoute,
//     );
//   }
// }

// Route<dynamic> _getRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case routes.healthCareAppointment:
//       return MaterialPageRoute(
//         settings: settings,
//         builder: (_) => const HealthCareAppointment(),
//         fullscreenDialog: true,
//       );

//     case routes.createAppointment:
//       return MaterialPageRoute(
//         settings: settings,
//         builder: (_) => const CreateAppointment(),
//         fullscreenDialog: true,
//       );

//     default:
//       return MaterialPageRoute(
//         settings: settings,
//         builder: (_) => const HealthCareAppointment(),
//         fullscreenDialog: true,
//       );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text('Main Page'),
//           ],
//         ),
//       ),
//       drawer: const MenuDrawer(),
//     );
//   }
// }
