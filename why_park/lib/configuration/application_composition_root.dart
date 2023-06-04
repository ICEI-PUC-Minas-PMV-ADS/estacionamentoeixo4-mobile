import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/application/park/park_detail_application_service.dart';
import 'package:why_park/application/park/park_query_application_service.dart';
import 'package:why_park/application/vehicle/vehicle_query_application_service.dart';
import 'package:why_park/edge/converters/park_resource_to_model_converter.dart';
import 'package:why_park/edge/http/auth_interceptor.dart';
import 'package:why_park/edge/http/custom_http_client.dart';
import 'package:why_park/edge/http/dio_http_client.dart';
import 'package:why_park/edge/services/park_detail_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/park_query_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/user_login_application_service_remote_adapter.dart';
import 'package:why_park/edge/services/vehicle_query_application_service_remote_adapter.dart';
import 'package:why_park/edge/session_storage/flutter_secure_session_storage.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';
import 'package:why_park/presentation/home/home_screen.dart';
import 'package:why_park/presentation/login/login_screen.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/park/park_detail_presenter/park_detail_presenter.dart';
import 'package:why_park/presentation/park/park_detail_screen.dart';
import 'package:why_park/presentation/park/park_presenter/park_presenter.dart';
import 'package:why_park/presentation/park/view_model/park_view_model.dart';
import 'package:why_park/presentation/reservation/reservation_screen.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/vehicle/model/vehicle_view_model.dart';
import 'package:why_park/presentation/vehicle/presenter/vehicle_presenter.dart';
import 'package:why_park/presentation/vehicle/vehicle_registration_screen.dart';

import '../presentation/park/park_detail_screen_arguments.dart';
import '../presentation/signup/signup_screen.dart';

class ApplicationCompositionRoot {
  ApplicationCompositionRoot() {
    // initialize dependencies
    _sessionStorage = createSessionStorage();
    _authInterceptor = createAuthInterceptor();
    _httpClient = createCustomHttpClient();
    _parkResourceToModelConverter = createParkResourceToModelConverter();
    _userAuthApplicationService = createUserRegistryApplicationService();
    _parkDetailApplicationService = createParkDetailApplicationService();
    _parkQueryApplicationService = createParkQueryApplicationService();
    _vehicleQueryApplicationService = createVehicleQueryApplicationService();
  }

  factory ApplicationCompositionRoot.instance() => _me;

  static final ApplicationCompositionRoot _me = ApplicationCompositionRoot();

  static const String _baseUrl = 'https://whypark.ddns.net';

  late final SessionStorage _sessionStorage;
  late final AuthInterceptor _authInterceptor;
  late final CustomHttpClient _httpClient;
  late final ParkResourceToModelConverter _parkResourceToModelConverter;
  late final UserAuthApplicationService _userAuthApplicationService;
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
  Widget newVehicleRegistrationScreen(final VehicleViewModel? viewModel) =>
      createVehicleRegistrationScreen(viewModel);

  @nonVirtual
  Widget newReservationScreen(final ParkViewModel viewModel) => createReservationScreen(viewModel);

  // Factories
  @protected
  CustomHttpClient createCustomHttpClient() =>
      DioHttpClient(urlBase: _baseUrl, authInterceptor: _authInterceptor);

  SessionStorage createSessionStorage() => FlutterSecureSessionStorage();

  AuthInterceptor createAuthInterceptor() => AuthInterceptor(_sessionStorage);

  @protected
  UserAuthApplicationService createUserRegistryApplicationService() =>
      UserAuthApplicationServiceRemoteAdapter();

  // AppServices factories

  @protected
  ParkDetailApplicationService createParkDetailApplicationService() =>
      ParkDetailApplicationServiceRemoteAdapter();

  @protected
  createParkQueryApplicationService() =>
      ParkQueryApplicationServiceRemoteAdapter(
          _httpClient, _parkResourceToModelConverter);

  @protected
  createVehicleQueryApplicationService() =>
      VehicleQueryApplicationServiceRemoteAdapter(_httpClient);

  // Converters factories

  @protected
  ParkResourceToModelConverter createParkResourceToModelConverter() =>
      ParkResourceToModelConverter();

  // Screens factories

  @protected
  Widget createLoginScreen() => LoginScreen(createLoginPresenter());

  @protected
  Widget createSignupScreen() => SignupScreen(createSignupPresenter());

  @protected
  Widget createHomeScreen() =>
      HomeScreen(createParkPresenter(), createVehiclePresenter());

  @protected
  Widget createParkDetailScreen(final ParkDetailScreenArguments arguments) =>
      ParkDetailScreen(
        createParkDetailPresenter(),
        arguments,
      );

  @protected
  Widget createVehicleRegistrationScreen(final VehicleViewModel? viewModel) =>
      VehicleRegistrationScreen(
        createVehiclePresenter(),
        viewModel,
      );

  @protected
  Widget createReservationScreen(final ParkViewModel viewModel) => ReservationScreen(viewModel);

  // Presenters factories

  @protected
  LoginPresenter createLoginPresenter() =>
      LoginPresenter(_userAuthApplicationService);

  @protected
  SignupPresenter createSignupPresenter() =>
      SignupPresenter(_userAuthApplicationService);

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
