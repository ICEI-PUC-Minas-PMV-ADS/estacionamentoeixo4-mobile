import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';

import '../../routes_table.dart';
import '../../utils/custom_dialog.dart';
import '../../utils/state_status.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen(this._signupPresenter, [final Key? key]) : super(key: key);

  final SignupPresenter _signupPresenter;

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _passwordIsVisible = false;
  bool _confirmPasswordIsVisible = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _confirmPasswordNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
              SizedBox(height: mediaQueryHeight * 0.03),
              Image.asset('assets/images/logo.png',
                  height: mediaQueryHeight * 0.15,
                  width: mediaQueryWidth * 0.45),
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
                            onChanged: (value) => widget._signupPresenter
                                .add(SignupFieldsChangedEvent("email", value)),
                            onFieldSubmitted: (_) =>
                                _nameFocusNode.requestFocus(),
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              errorText: state.status == Status.invalid
                                  ? 'Email inválido'
                                  : null,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          TextFormField(
                            validator: ValidationBuilder(localeName: 'pt-br')
                                .minLength(3)
                                .maxLength(50)
                                .build(),
                            focusNode: _nameFocusNode,
                            onChanged: (value) => widget._signupPresenter
                                .add(SignupFieldsChangedEvent("name", value)),
                            onFieldSubmitted: (_) =>
                                _passwordFocusNode.requestFocus(),
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                              filled: true,
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          TextFormField(
                            validator: ValidationBuilder(localeName: 'pt-br')
                                .minLength(6)
                                .maxLength(50)
                                .build(),
                            controller: _controller,
                            focusNode: _passwordFocusNode,
                            onChanged: (value) => widget._signupPresenter.add(
                                SignupFieldsChangedEvent("password", value)),
                            onFieldSubmitted: (_) =>
                                _confirmPasswordNode.requestFocus(),
                            obscureText: !_passwordIsVisible,
                            decoration: InputDecoration(
                              labelText: 'Digita sua senha',
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
                          SizedBox(height: mediaQueryHeight * 0.03),
                          TextFormField(
                            validator: ValidationBuilder(localeName: 'pt-br')
                                .minLength(6)
                                .maxLength(50)
                                .build(),
                            focusNode: _confirmPasswordNode,
                            onChanged: (value) => widget._signupPresenter.add(
                                SignupFieldsChangedEvent(
                                    "confirmPassword", value)),
                            obscureText: !_confirmPasswordIsVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirma sua senha',
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _confirmPasswordIsVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordIsVisible =
                                        !_confirmPasswordIsVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight * 0.03),
                          BlocListener<SignupPresenter, SignupState>(
                            bloc: widget._signupPresenter,
                            listener: (context, state) {
                              if (state.status == Status.success) {
                                Navigator.of(context)
                                    .pushNamed(RoutesTable.login);
                              } else if (state.status == Status.failure) {
                                CustomDialog.showCustomDialog(
                                  context,
                                  state.status,
                                  'Erro no cadastro',
                                  'Ocorreu um erro ao fazer o seu cadastro. Verifique os campos e tente novamente.',
                                );
                              } else if (state.status == Status.invalid) {
                                CustomDialog.showCustomDialog(
                                  context,
                                  state.status,
                                  'Erro no cadastro',
                                  'Verifique os campos. As senhas não conferem.',
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
                                        widget._signupPresenter
                                            .add(SignupClickedEvent());
                                      }
                                    },
                                    child: const Text(
                                      'Cadastrar',
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Já tem uma conta?'),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .popAndPushNamed(RoutesTable.login),
                                child: const Text(
                                  'Acesse',
                                ),
                              )
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
