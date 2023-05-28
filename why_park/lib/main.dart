import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:why_park/routes_table.dart';

import 'commons/commons_theme/theme_data.dart';
import 'commons/commons_theme/theme_provider.dart';
import 'configuration/application_composition_root.dart';

// FIREBASE
import 'package:firebase_core/firebase_core.dart';

final ApplicationCompositionRoot _applicationCompositionRoot =
    ApplicationCompositionRoot.instance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: MyApp.navigatorKey,
            scaffoldMessengerKey: MyApp.scaffoldKey,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: _applicationCompositionRoot.newLoginScreen(),
            routes: RoutesTable.routes,
          );
        },
      ),
    );
  }
}
