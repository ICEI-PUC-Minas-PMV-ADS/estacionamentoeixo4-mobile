import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/login/presenter/login_events.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/login/presenter/login_state.dart';
import 'package:why_park/routes_table.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(final Key? key, this._loginPresenter) : super(key: key);

  final LoginPresenter _loginPresenter;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordIsVisible = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(31.0, 0.0, 31.0, bottom),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: mediaQueryHeight * 0.03),
              Image.asset('assets/images/logo.png',
                  height: mediaQueryHeight * 0.25,
                  width: mediaQueryWidth * 0.70),
              SizedBox(height: mediaQueryHeight * 0.03),
              BlocBuilder<LoginPresenter, LoginState>(
                  bloc: widget._loginPresenter,
                  builder: (final _, final state) {
                    return Column(
                      children: [
                        TextFormField(
                          focusNode: _emailFocusNode,
                          onChanged: (value) => widget._loginPresenter
                              .add(LoginFieldsChangedEvent("email", value)),
                          onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: mediaQueryHeight * 0.03),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          onChanged: (value) => widget._loginPresenter
                              .add(LoginFieldsChangedEvent("password", value)),
                          obscureText: !_passwordIsVisible,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordIsVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordIsVisible = !_passwordIsVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
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
              OutlinedButton(
                onPressed: () {
                  widget._loginPresenter.add(LoginClickedEvent());
                  Navigator.of(context).pushNamed(RoutesTable.home);
                },
                child: const Text(
                  'Entrar',
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
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RoutesTable.signup),
                    child: const Text('Cadastre-se'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
