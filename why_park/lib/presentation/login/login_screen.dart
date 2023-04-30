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

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(31.0),
        child: Column(
          children: [
            SizedBox(height: mediaQueryHeight * 0.03),
            Image.asset('assets/images/logo.png',
                height: mediaQueryHeight * 0.25, width: mediaQueryWidth * 0.70),
            SizedBox(height: mediaQueryHeight * 0.03),
            BlocBuilder<LoginPresenter, LoginState>(
                bloc: widget._loginPresenter,
                builder: (final _, final state) {
                  return Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => widget._loginPresenter
                            .add(LoginFieldsChangedEvent("email", value)),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF262626)),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.03),
                      TextFormField(
                        onChanged: (value) => widget._loginPresenter
                            .add(LoginFieldsChangedEvent("password", value)),
                        style: const TextStyle(color: Colors.white),
                        obscureText: !_passwordIsVisible,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(color: Colors.white),
                          fillColor: const Color(0xFF262626),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordIsVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF5E5CE5),
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
              children: const [
                TextButton(
                  onPressed: null,
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: mediaQueryHeight * 0.02),
            OutlinedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RoutesTable.home),
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E5CE5)),
              child: const Text(
                'Entrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            Row(children: [
              const Expanded(
                  child: Divider(
                color: Color(0xFF959595),
                thickness: 1.0,
              )),
              SizedBox(width: mediaQueryWidth * 0.02),
              const Text(
                'ou',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: mediaQueryWidth * 0.02),
              const Expanded(
                  child: Divider(
                color: Color(0xFF959595),
                thickness: 1.0,
              ))
            ]),
            SizedBox(height: mediaQueryHeight * 0.03),
            OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E5CE5)),
              child: const Text(
                'Entrar com a conta google',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RoutesTable.signup),
                child: const Text('Não tem uma conta? Cadastre-se',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
