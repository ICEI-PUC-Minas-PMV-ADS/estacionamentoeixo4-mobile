// Mocks generated by Mockito 5.4.0 from annotations
// in why_park/test/login_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:why_park/application/account/model/user_account_model.dart'
    as _i4;
import 'package:why_park/application/account/user_registry_application_service.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [UserAuthApplicationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserAuthApplicationService extends _i1.Mock
    implements _i2.UserAuthApplicationService {
  MockUserAuthApplicationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> loginWithEmailAndPassword(_i4.UserAccountModel? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithEmailAndPassword,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> signUpWithEmailAndPassword(_i4.UserAccountModel? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpWithEmailAndPassword,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> loginWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #loginWithGoogle,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
