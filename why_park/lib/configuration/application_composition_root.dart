import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/application/park/park_detail_application_service.dart';
import 'package:why_park/edge/converters/user_account_model_to_resource_converter.dart';
import 'package:why_park/edge/http/custom_http_client.dart';
import 'package:why_park/edge/http/dio_http_client.dart';
import 'package:why_park/edge/services/park_detail_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/user_registry_application_service_remote_adapter.dart';
import 'package:why_park/presentation/home/home_screen.dart';
import 'package:why_park/presentation/login/login_screen.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_presenter.dart';
import 'package:why_park/presentation/park/park_detail_screen.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';

import '../presentation/park/park_detail_screen_arguments.dart';
import '../presentation/signup/signup_screen.dart';

class ApplicationCompositionRoot {
  ApplicationCompositionRoot() {
    // initialize dependencies
    _httpClient = createCustomHttpClient();
    _accountModelToResourceConverter =
        createUserAccountModelToResourceConverter();
    _userRegistryApplicationService = createUserRegistryApplicationService();
    _parkDetailApplicationService = createParkDetailApplicationService();
  }

  factory ApplicationCompositionRoot.instance() => _me;

  static final ApplicationCompositionRoot _me = ApplicationCompositionRoot();

  static const String _baseUrl = 'http://10.0.2.2:3000';

  late final CustomHttpClient _httpClient;
  late final UserAccountModelToResourceConverter
      _accountModelToResourceConverter;
  late final UserRegistryApplicationService _userRegistryApplicationService;
  late final ParkDetailApplicationService _parkDetailApplicationService;

  // Injectable Properties
  // ex: services, converters, remoteGateways

  get httpClient => _httpClient;

  // Screen getters
  @nonVirtual
  Widget newLoginScreen() => createLoginScreen();

  @nonVirtual
  Widget newSignupScreen() => createSignupScreen();

  @nonVirtual
  Widget newHomeScreen() => createHomeScreen();

  @nonVirtual
  newParkDetailScreen(final ParkDetailScreenArguments arguments) =>
      createParkDetailScreen(arguments);

  // Factories
  @protected
  CustomHttpClient createCustomHttpClient() => DioHttpClient(urlBase: _baseUrl);

  @protected
  UserRegistryApplicationService createUserRegistryApplicationService() =>
      UserRegistryApplicationServiceRemoteAdapter(
          _httpClient, _accountModelToResourceConverter);

  @protected
  ParkDetailApplicationService createParkDetailApplicationService() =>
      ParkDetailApplicationServiceRemoteAdapter();

  @protected
  UserAccountModelToResourceConverter
      createUserAccountModelToResourceConverter() =>
          UserAccountModelToResourceConverter();

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
  Widget createHomeScreen() => HomeScreen(null, createParkPresenter());

  @protected
  Widget createParkDetailScreen(final ParkDetailScreenArguments arguments) =>
      ParkDetailScreen(
        null,
        createParkDetailPresenter(),
        arguments,
      );

  @protected
  LoginPresenter createLoginPresenter() => LoginPresenter();

  @protected
  SignupPresenter createSignupPresenter() =>
      SignupPresenter(_userRegistryApplicationService);

  @protected
  ParkPresenter createParkPresenter() => ParkPresenter();

  @protected
  ParkDetailPresenter createParkDetailPresenter() =>
      ParkDetailPresenter(_parkDetailApplicationService);
}
