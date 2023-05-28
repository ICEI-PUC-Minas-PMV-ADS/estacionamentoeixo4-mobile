import 'package:bloc/bloc.dart';
import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

class SignupPresenter extends Bloc<SignupEvent, SignupState> {
  SignupPresenter(this._userRegistryApplicationService) : super(const SignupState()) {
    on<SignupClickedEvent>(_onSignupSubmitted);
    on<SignupFieldsChangedEvent>(_onFieldChangedEvent);
  }

  final UserRegistryApplicationService _userRegistryApplicationService;

  _onFieldChangedEvent(
      final SignupFieldsChangedEvent event, final Emitter<SignupState> emit) {
    switch (event.label) {
      case "email":
        emit(state.copyWith(email: event.value));
        break;
      case "name":
        emit(state.copyWith(name: event.value));
        break;
      case "password":
        emit(state.copyWith(password: event.value));
        break;
      case "confirmPassword":
        emit(state.copyWith(confirmPassword: event.value));
        break;
    }
  }

  _onSignupSubmitted(final _, final Emitter<SignupState> emit) {
    _userRegistryApplicationService.createAccount(UserAccountModel(state.email, state.name, state.password));
  }
}
