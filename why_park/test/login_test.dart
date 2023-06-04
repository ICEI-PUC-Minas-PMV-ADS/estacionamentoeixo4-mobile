import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/presentation/login/presenter/login_events.dart';
import 'package:why_park/presentation/login/presenter/login_presenter.dart';
import 'package:why_park/presentation/login/presenter/login_state.dart';
import 'package:why_park/utils/state_status.dart';

import 'login_test.mocks.dart';

@GenerateMocks([UserAuthApplicationService])
void main() {
  final UserAuthApplicationService mockAuthService =
      MockUserAuthApplicationService();
  final LoginPresenter presenter = LoginPresenter(mockAuthService);

  group('LoginPresenter', () {
    const mockEmail = 'test@example.com';
    const mockPassword = 'password';

    test('initial state is LoginState', () {
      expect(presenter.state, const LoginState());
    });

    group('LoginSubmitted', () {
      blocTest<LoginPresenter, LoginState>(
        'Update email',
        build: () => LoginPresenter(
          mockAuthService,
        ),
        act: (bloc) => bloc.add(LoginFieldsChangedEvent('email', mockEmail)),
        expect: () => const <LoginState>[
          LoginState(email: mockEmail, password: '', status: Status.initial),
        ],
      );

      blocTest<LoginPresenter, LoginState>(
        'Update password',
        build: () => LoginPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(LoginFieldsChangedEvent('password', mockPassword));
        },
        expect: () => const <LoginState>[
          LoginState(email: '', password: mockPassword, status: Status.initial),
        ],
      );

      blocTest<LoginPresenter, LoginState>(
        'Login Success',
        build: () => LoginPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(LoginFieldsChangedEvent('email', mockEmail));
          bloc.add(LoginFieldsChangedEvent('password', mockPassword));
          bloc.add(LoginClickedEvent());
        },
        expect: () => const <LoginState>[
          LoginState(email: mockEmail, password: '', status: Status.initial),
          LoginState(
              email: mockEmail, password: mockPassword, status: Status.initial),
          LoginState(
              email: mockEmail, password: mockPassword, status: Status.loading),
          LoginState(
              email: mockEmail, password: mockPassword, status: Status.success),
        ],
      );
    });
  });
}
