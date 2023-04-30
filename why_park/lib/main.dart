import 'package:flutter/material.dart';
import 'package:why_park/routes_table.dart';

import 'configuration/application_composition_root.dart';

final ApplicationCompositionRoot _applicationCompositionRoot =
    ApplicationCompositionRoot.instance();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _applicationCompositionRoot.newLoginScreen(),
      routes: RoutesTable.routes
    );
  }
}
