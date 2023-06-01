import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/edge/services/user_login_application_service_remote_adapter.dart';
import 'package:why_park/routes_table.dart';

import '../../../application/account/model/user_account_model.dart';
import '../../../application/account/user_registry_application_service.dart';
import 'login_events.dart';
import 'login_state.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  LoginPresenter(this._userAuthApplicationService)
      : super(const LoginState()) {
    on<LoginClickedEvent>((event, emit) {
      _onLoginSubmitted(event.context, emit);
    });
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

  _onLoginSubmitted(
      final BuildContext context, final Emitter<LoginState> emit) async {
    print(state.email);
    print(state.password);

    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      try {
        await _userAuthApplicationService.loginWithEmailAndPassword(
            UserAccountModel(state.email, state.password));
        Navigator.of(context).pushNamed(RoutesTable.home);
      } catch (e) {
        print(e);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Erro de login',
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                'Ocorreu um erro ao fazer login. Verifique suas credenciais e tente novamente.',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
