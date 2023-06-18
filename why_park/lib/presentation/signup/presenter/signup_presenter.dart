import 'package:bloc/bloc.dart';
import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

import '../../../utils/state_status.dart';

class SignupPresenter extends Bloc<SignupEvent, SignupState> {
  SignupPresenter(this._userAuthApplicationService)
      : super(const SignupState()) {
    on<SignupClickedEvent>(_onSignupSubmitted);
    on<SignupFieldsChangedEvent>(_onFieldChangedEvent);
  }

  final UserAuthApplicationService _userAuthApplicationService;

  Future<void> _onFieldChangedEvent(final SignupFieldsChangedEvent event,
      final Emitter<SignupState> emit) async {
    switch (event.label) {
      case "email":
        emit(state.copyWith(email: event.value, status: Status.initial));
        break;
      case "name":
        emit(state.copyWith(name: event.value, status: Status.initial));
        break;
      case "password":
        emit(state.copyWith(password: event.value, status: Status.initial));
        break;
      case "confirmPassword":
        emit(state.copyWith(confirmPassword: event.value, status: Status.initial));
        break;
    }
  }

  Future<void> _onSignupSubmitted(
      final _, final Emitter<SignupState> emit) async {
    if (!_isPasswordEquals()) {
      emit(state.copyWith(status: Status.invalid));
    } else {
      try {
        emit(state.copyWith(status: Status.loading));
        await _userAuthApplicationService.signUpWithEmailAndPassword(
            UserAccountModel(state.email, state.password, state.name));
        emit(state.copyWith(status: Status.success));
      } on Exception catch (e) {
        emit(state.copyWith(status: Status.failure));
      }
    }
  }

  bool _isPasswordEquals() => state.password == state.confirmPassword;
}
