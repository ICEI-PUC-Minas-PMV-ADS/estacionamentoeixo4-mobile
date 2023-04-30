import 'package:bloc/bloc.dart';

import 'login_events.dart';
import 'login_state.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  LoginPresenter() : super(const LoginState()) {
    on<LoginClickedEvent>(_onLoginSubmitted);
    on<LoginFieldsChangedEvent>(_onFieldChangedEvent);
  }

  _onFieldChangedEvent(
      final LoginFieldsChangedEvent event, final Emitter<LoginState> emit) {
    switch (event.label) {
      case "email":
        emit(state.copyWith(email: event.value));
        break;
      case "password":
        emit(state.copyWith(password: event.value));
        break;
    }
  }

  _onLoginSubmitted(final _, final Emitter<LoginState> emit) {
    // TODO: chamar o serviço de Login
  }
}
