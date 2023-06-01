import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:why_park/application/account/model/user_account_model.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

import '../../../routes_table.dart';
import '../../login/presenter/login_service.dart';

class SignupPresenter extends Bloc<SignupEvent, SignupState> {
  SignupPresenter(this._userRegistryApplicationService)
      : super(const SignupState()) {
    on<SignupClickedEvent>((event, emit) {
      _onSignupSubmitted(event.context, emit);
    });
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

  _onSignupSubmitted(
      final BuildContext context, final Emitter<SignupState> emit) async {
    _userRegistryApplicationService.createAccount(
        UserAccountModel(state.email, state.name, state.password));

    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      try {
        await LoginService.signUpWithEmailAndPassword(
            email: state.email, password: state.password);
        Navigator.of(context).pushNamed(RoutesTable.login);
      } catch (e) {
        print(e);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Erro ao cadastrar',
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                'Ocorreu um erro ao cadastar. Verifique as informações e tente novamente.',
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
