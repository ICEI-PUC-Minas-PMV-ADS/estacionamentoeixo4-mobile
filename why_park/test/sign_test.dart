import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:why_park/application/account/user_registry_application_service.dart';
import 'package:why_park/presentation/signup/presenter/sign_events.dart';
import 'package:why_park/presentation/signup/presenter/signup_presenter.dart';
import 'package:why_park/presentation/signup/presenter/signup_state.dart';
import 'package:why_park/utils/state_status.dart';

import 'sign_test.mocks.dart';

@GenerateMocks([UserAuthApplicationService])
void main() {
  final UserAuthApplicationService mockAuthService =
      MockUserAuthApplicationService();
  final SignupPresenter presenter = SignupPresenter(mockAuthService);

  group('SignUpPresenter', () {
    const mockEmail = 'test@example.com';
    const mockName = 'test';
    const mockPassword = 'password';
    const mockConfirmPassword = 'confirmPassword';

    test('initial state is SignUpState', () {
      expect(presenter.state, const SignupState());
    });

    group('SignUpSubmitted', () {
      blocTest<SignupPresenter, SignupState>(
        'Update email',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) => bloc.add(SignupFieldsChangedEvent('email', mockEmail)),
        expect: () => const <SignupState>[
          SignupState(
            email: mockEmail,
            name: '',
            password: '',
            confirmPassword: '',
            status: Status.initial,
          ),
        ],
      );

      blocTest<SignupPresenter, SignupState>(
        'Update name',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(SignupFieldsChangedEvent('name', mockName));
        },
        expect: () => const <SignupState>[
          SignupState(
            email: '',
            name: mockName,
            password: '',
            confirmPassword: '',
            status: Status.initial,
          ),
        ],
      );

      blocTest<SignupPresenter, SignupState>(
        'Update password',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(SignupFieldsChangedEvent('password', mockPassword));
        },
        expect: () => const <SignupState>[
          SignupState(
            email: '',
            name: '',
            password: mockPassword,
            confirmPassword: '',
            status: Status.initial,
          ),
        ],
      );

      blocTest<SignupPresenter, SignupState>(
        'Update confirmPassword',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(SignupFieldsChangedEvent('confirmPassword', mockConfirmPassword));
        },
        expect: () => const <SignupState>[
          SignupState(
            email: '',
            name: '',
            password: '',
            confirmPassword: mockConfirmPassword,
            status: Status.initial,
          ),
        ],
      );

      blocTest<SignupPresenter, SignupState>(
        'SignUp invalid when passwords does not matches',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(SignupFieldsChangedEvent('email', mockEmail));
          bloc.add(SignupFieldsChangedEvent('name', mockName));
          bloc.add(SignupFieldsChangedEvent('password', mockPassword));
          bloc.add(
              SignupFieldsChangedEvent('confirmPassword', mockConfirmPassword));
          bloc.add(SignupClickedEvent());
        },
        expect: () => const <SignupState>[
          SignupState(
              email: mockEmail,
              name: '',
              password: '',
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: '',
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: mockConfirmPassword,
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: mockConfirmPassword,
              status: Status.invalid),
        ],
      );

      blocTest<SignupPresenter, SignupState>(
        'SignUp Success',
        build: () => SignupPresenter(
          mockAuthService,
        ),
        act: (bloc) {
          bloc.add(SignupFieldsChangedEvent('email', mockEmail));
          bloc.add(SignupFieldsChangedEvent('name', mockName));
          bloc.add(SignupFieldsChangedEvent('password', mockPassword));
          bloc.add(
              SignupFieldsChangedEvent('confirmPassword', mockPassword));
          bloc.add(SignupClickedEvent());
        },
        expect: () => const <SignupState>[
          SignupState(
              email: mockEmail,
              name: '',
              password: '',
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: '',
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: '',
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: mockPassword,
              status: Status.initial),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: mockPassword,
              status: Status.loading),
          SignupState(
              email: mockEmail,
              name: mockName,
              password: mockPassword,
              confirmPassword: mockPassword,
              status: Status.success),
        ],
      );
    });
  });
}
