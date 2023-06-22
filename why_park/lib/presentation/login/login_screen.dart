import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:why_park/presentation/login/presenter/login_events.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/login/presenter/login_state.dart';
import 'package:why_park/routes_table.dart';
import 'package:why_park/utils/custom_dialog.dart';

import '../../utils/state_status.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this._loginPresenter, [final Key? key]) : super(key: key);

  final LoginPresenter _loginPresenter;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordIsVisible = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31.0, 0.0, 31.0, 0.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: mediaQueryHeight * 0.04),
              Image.asset('assets/images/why_park.png',
                  height: mediaQueryHeight * 0.25,
                  width: mediaQueryWidth * 0.70),
              SizedBox(height: mediaQueryHeight * 0.03),
              BlocBuilder<LoginPresenter, LoginState>(
                  bloc: widget._loginPresenter,
                  builder: (final _, final state) {
                    return Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: _emailFocusNode,
                            validator: ValidationBuilder(localeName: 'pt-br')
                                .email()
                                .maxLength(50)
                                .build(),
                            onChanged: (value) => widget._loginPresenter
                                .add(LoginFieldsChangedEvent("email", value)),
                            onFieldSubmitted: (_) =>
                                _passwordFocusNode.requestFocus(),
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              filled: true,
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          TextFormField(
                            validator: ValidationBuilder(localeName: 'pt-br')
                                .minLength(6)
                                .maxLength(50)
                                .build(),
                            focusNode: _passwordFocusNode,
                            onChanged: (value) => widget._loginPresenter.add(
                                LoginFieldsChangedEvent("password", value)),
                            obscureText: !_passwordIsVisible,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordIsVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordIsVisible = !_passwordIsVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => print('teste'),
                                child: const Text(
                                  'Esqueci minha senha',
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: mediaQueryHeight * 0.02),
                          BlocListener<LoginPresenter, LoginState>(
                            bloc: widget._loginPresenter,
                            listener: (context, state) {
                              if (state.status == Status.success) {
                                Navigator.of(context)
                                    .popAndPushNamed(RoutesTable.home);
                              } else if (state.status == Status.failure) {
                                CustomDialog.showCustomDialog(
                                  context,
                                  state.status,
                                  'Erro de login',
                                  'Ocorreu um erro ao fazer login. Verifique suas credenciais e tente novamente.',
                                );
                              }
                            },
                            child: state.status == Status.loading
                                ? const CircularProgressIndicator()
                                : OutlinedButton(
                                    onPressed: () {
                                      final valid =
                                          _form.currentState?.validate() ??
                                              false;
                                      if (valid) {
                                        widget._loginPresenter
                                            .add(LoginClickedEvent());
                                      }
                                      // Navigator.of(context).pushNamed(RoutesTable.home);
                                    },
                                    child: const Text(
                                      'Entrar',
                                    ),
                                  ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          Row(children: [
                            const Expanded(
                                child: Divider(
                              thickness: 1.0,
                            )),
                            SizedBox(width: mediaQueryWidth * 0.02),
                            const Text(
                              'ou',
                            ),
                            SizedBox(width: mediaQueryWidth * 0.02),
                            const Expanded(
                                child: Divider(
                              thickness: 1.0,
                            ))
                          ]),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          const OutlinedButton(
                            onPressed: null,
                            child: Text(
                              'Entrar com a conta google',
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não tem uma conta?'),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .popAndPushNamed(RoutesTable.signup),
                                child: const Text('Cadastre-se'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
