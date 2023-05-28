import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/application/park/park_detail_application_service.dart';
import 'package:why_park/application/park/park_query_application_service.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/edge/converters/user_account_model_to_resource_converter.dart';
import 'package:why_park/edge/http/custom_http_client.dart';
import 'package:why_park/edge/http/dio_http_client.dart';
import 'package:why_park/edge/services/park_detail_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/park_query_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/user_registry_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/vehicle_query_application_service_remote_adapter.dart';
import 'package:why_park/presentation/home/home_screen.dart';
import 'package:why_park/presentation/login/login_screen.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_presenter.dart';
import 'package:why_park/presentation/park/park_detail_screen.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'package:why_park/presentation/vehicle/vehicle_registration_screen.dart';

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
    _parkQueryApplicationService = createParkQueryApplicationService();
    _vehicleQueryApplicationService = createVehicleQueryApplicationService();
  }

  factory ApplicationCompositionRoot.instance() => _me;

  static final ApplicationCompositionRoot _me = ApplicationCompositionRoot();

  static const String _baseUrl = 'http://10.0.2.2:3000';

  late final CustomHttpClient _httpClient;
  late final UserAccountModelToResourceConverter
      _accountModelToResourceConverter;
  late final UserRegistryApplicationService _userRegistryApplicationService;
  late final ParkDetailApplicationService _parkDetailApplicationService;
  late final ParkQueryApplicationService _parkQueryApplicationService;
  late final VehicleQueryApplicationService _vehicleQueryApplicationService;

  // Injectable properties
  // ex: services, converters, remoteGateways

  get httpClient => _httpClient;

  // Screen factories getters
  @nonVirtual
  Widget newLoginScreen() => createLoginScreen();

  @nonVirtual
  Widget newSignupScreen() => createSignupScreen();

  @nonVirtual
  Widget newHomeScreen() => createHomeScreen();

  @nonVirtual
  newParkDetailScreen(final ParkDetailScreenArguments arguments) =>
      createParkDetailScreen(arguments);

  @nonVirtual
  Widget newVehicleRegistrationScreen() => createVehicleRegistrationScreen();

  // Factories
  @protected
  CustomHttpClient createCustomHttpClient() => DioHttpClient(urlBase: _baseUrl);

  @protected
  UserRegistryApplicationService createUserRegistryApplicationService() =>
      UserRegistryApplicationServiceRemoteAdapter(
          _httpClient, _accountModelToResourceConverter);

  // AppServices factories

  @protected
  ParkDetailApplicationService createParkDetailApplicationService() =>
      ParkDetailApplicationServiceRemoteAdapter();

  @protected
  createParkQueryApplicationService() =>
      ParkQueryApplicationServiceRemoteAdapter(_httpClient);

  @protected
  createVehicleQueryApplicationService() =>
      VehicleQueryApplicationServiceRemoteAdapter(_httpClient);

  // Converters factories

  @protected
  UserAccountModelToResourceConverter
      createUserAccountModelToResourceConverter() =>
          UserAccountModelToResourceConverter();

  // Screens factories

  @protected
  Widget createLoginScreen() => LoginScreen(createLoginPresenter());

  @protected
  Widget createSignupScreen() => SignupScreen(createSignupPresenter());

  @protected
  Widget createHomeScreen() => HomeScreen(createParkPresenter());

  @protected
  Widget createParkDetailScreen(final ParkDetailScreenArguments arguments) =>
      ParkDetailScreen(
        createParkDetailPresenter(),
        arguments,
      );

  @protected
  Widget createVehicleRegistrationScreen() =>
      VehicleRegistrationScreen(createVehiclePresenter());

  // Presenters factories

  @protected
  LoginPresenter createLoginPresenter() => LoginPresenter();

  @protected
  SignupPresenter createSignupPresenter() =>
      SignupPresenter(_userRegistryApplicationService);

  @protected
  ParkPresenter createParkPresenter() =>
      ParkPresenter(_parkQueryApplicationService);

  @protected
  ParkDetailPresenter createParkDetailPresenter() =>
      ParkDetailPresenter(_parkDetailApplicationService);

  @protected
  VehiclePresenter createVehiclePresenter() =>
      VehiclePresenter(_vehicleQueryApplicationService);
}
