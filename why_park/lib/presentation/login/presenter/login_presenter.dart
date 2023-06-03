import 'package:bloc/bloc.dart';

import '../../../application/account/model/user_account_model.dart';
import '../../../application/account/user_registry_application_service.dart';
import '../../../utils/state_status.dart';
import 'login_events.dart';
import 'login_state.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  LoginPresenter(this._userAuthApplicationService) : super(const LoginState()) {
    on<LoginClickedEvent>(_onLoginSubmitted);
    on<LoginFieldsChangedEvent>(_onFieldChangedEvent);
  }

  final UserAuthApplicationService _userAuthApplicationService;

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

  Future<void> _onLoginSubmitted(final _, final Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      await _userAuthApplicationService.loginWithEmailAndPassword(
          UserAccountModel(state.email, state.password));
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
