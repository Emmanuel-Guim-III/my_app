import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String appName;
  final String flavorName;

  const AppConfig({
    Key? key,
    required this.appName,
    required this.flavorName,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }
}
