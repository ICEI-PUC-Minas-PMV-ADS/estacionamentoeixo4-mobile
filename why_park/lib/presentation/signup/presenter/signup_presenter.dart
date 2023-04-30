import 'package:bloc/bloc.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

class SignupPresenter extends Bloc<SignupEvent, SignupState> {
  SignupPresenter() : super(const SignupState()) {
    on<SignupClickedEvent>(_onSignupSubmitted);
    on<SignupFieldsChangedEvent>(_onFieldChangedEvent);
  }

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
    // TODO: chamar o serviço de Signup
  }
}
