import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/presentation/login/presenter/login_service.dart';
import 'package:why_park/routes_table.dart';

import 'login_events.dart';
import 'login_state.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  LoginPresenter() : super(const LoginState()) {
    on<LoginClickedEvent>((event, emit) {
      _onLoginSubmitted(event.context, emit);
    });
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

  _onLoginSubmitted(
      final BuildContext context, final Emitter<LoginState> emit) async {
    print(state.email);
    print(state.password);

    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      try {
        await LoginService.loginWithEmailAndPassword(
            email: state.email, password: state.password);
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
