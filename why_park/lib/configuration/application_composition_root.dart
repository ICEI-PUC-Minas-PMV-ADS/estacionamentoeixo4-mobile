import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/presentation/home/home_screen.dart';
import 'package:why_park/presentation/login/login_screen.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/vehicle/vehicle_registration_screen.dart';

import '../presentation/signup/signup_screen.dart';

class ApplicationCompositionRoot {
  ApplicationCompositionRoot();

  factory ApplicationCompositionRoot.instance() => _me;

  static final ApplicationCompositionRoot _me = ApplicationCompositionRoot();

  // Injectable Properties
  // ex: services, converters, remoteGateways

  // Screen getters
  @nonVirtual
  Widget newLoginScreen() => createLoginScreen();

  @nonVirtual
  Widget newSignupScreen() => createSignupScreen();

  @nonVirtual
  Widget newHomeScreen() => createHomeScreen();

  @nonVirtual
  Widget newVehicleRegistrationScreen() => createVehicleRegistrationScreen();

  // Factories
  @protected
  Widget createLoginScreen() => LoginScreen(
        null,
        createLoginPresenter(),
      );

  @protected
  Widget createSignupScreen() => SignupScreen(
        null,
        createSignupPresenter(),
      );

  @protected
  Widget createHomeScreen() => const HomeScreen();

  @protected
  Widget createVehicleRegistrationScreen() =>
      const VehicleRegistrationScreen(null);

  @protected
  LoginPresenter createLoginPresenter() => LoginPresenter();

  @protected
  SignupPresenter createSignupPresenter() => SignupPresenter();
}
