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
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(31.0),
        child: Column(
          children: [
            SizedBox(height: mediaQueryHeight * 0.03),
            Image.asset('assets/images/logo.png',
                height: mediaQueryHeight * 0.15, width: mediaQueryWidth * 0.45),
            SizedBox(height: mediaQueryHeight * 0.04),
            const Text(
              'Faça seu cadastro, para encontrar as melhores vagas em estacionamentos.',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.04),
            BlocBuilder<SignupPresenter, SignupState>(
                bloc: widget._signupPresenter,
                builder: (final _, final state) {
                  return TextFormField(
                    onChanged: (value) => widget._signupPresenter
                        .add(SignupFieldsChangedEvent("email", value)),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: Colors.white),
                      errorText: state.status == Status.invalid
                          ? 'Email inválido'
                          : null,
                      fillColor: const Color(0xFF262626),
                      filled: true,
                    ),
                  );
                }),
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("name", value)),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Color(0xFF262626),
                filled: true,
              ),
            ),
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("password", value)),
              style: const TextStyle(color: Colors.white),
              obscureText: !_passwordIsVisible,
              decoration: InputDecoration(
                labelText: 'Digita sua senha',
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
            SizedBox(height: mediaQueryHeight * 0.03),
            TextFormField(
              onChanged: (value) => widget._signupPresenter
                  .add(SignupFieldsChangedEvent("confirmPassword", value)),
              style: const TextStyle(color: Colors.white),
              obscureText: !_confirmPasswordIsVisible,
              decoration: InputDecoration(
                labelText: 'Confirma sua senha',
                labelStyle: const TextStyle(color: Colors.white),
                fillColor: const Color(0xFF262626),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordIsVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF5E5CE5),
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
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E5CE5)),
              child: const Text(
                'Cadastrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Já tem uma conta? Acesse',
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
