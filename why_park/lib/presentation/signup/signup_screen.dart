import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen(final Key? key, this._signupPresenter) : super(key: key);

  final SignupPresenter _signupPresenter;

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _passwordIsVisible = false;
  bool _confirmPasswordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(31.0),
        child: Column(
          children: [
            SizedBox(height: mediaQueryHeight * 0.03),
            Image.asset('assets/images/logo.png',
                height: mediaQueryHeight * 0.15, width: mediaQueryWidth * 0.45),
            SizedBox(height: mediaQueryHeight * 0.03),
            const Text(
              'Cadastre-se para encontrar as melhores vagas em estacionamentos.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            BlocBuilder<SignupPresenter, SignupState>(
                bloc: widget._signupPresenter,
                builder: (final _, final state) {
                  return TextFormField(
                    onChanged: (value) => widget._signupPresenter
                        .add(SignupFieldsChangedEvent("email", value)),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      errorText: state.status == Status.invalid
                          ? 'Email inválido'
                          : null,
                      filled: true,
                    ),
                  );
                }),
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("name", value)),
              decoration: const InputDecoration(
                labelText: 'Nome',
                filled: true,
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("password", value)),
              obscureText: !_passwordIsVisible,
              decoration: InputDecoration(
                labelText: 'Digita sua senha',
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
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("confirmPassword", value)),
              obscureText: !_confirmPasswordIsVisible,
              decoration: InputDecoration(
                labelText: 'Confirma sua senha',
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordIsVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordIsVisible = !_confirmPasswordIsVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            OutlinedButton(
              onPressed: () =>
                  widget._signupPresenter.add(SignupClickedEvent()),
              child: const Text(
                'Cadastrar',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Já tem uma conta?'),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Acesse',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
