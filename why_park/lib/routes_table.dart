import 'package:flutter/cupertino.dart';
import 'package:why_park/configuration/application_composition_root.dart';

class RoutesTable {
  RoutesTable._();

  static final ApplicationCompositionRoot _applicationCompositionRoot =
      ApplicationCompositionRoot.instance();

  // routes name
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';

  // routes mapper
  static Map<String, Widget Function(BuildContext)> routes = {
    login: (final context) => _applicationCompositionRoot.newLoginScreen(),
    signup: (final context) => _applicationCompositionRoot.newSignupScreen(),
    home: (final context) => _applicationCompositionRoot.newHomeScreen(),
  };
}
