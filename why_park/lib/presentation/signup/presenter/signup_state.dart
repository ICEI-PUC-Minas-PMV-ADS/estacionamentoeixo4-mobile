import 'package:equatable/equatable.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class SignupState extends Equatable {
  const SignupState({
    this.email = '',
    this.name = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = Status.initial,
  });

  final String email;
  final String name;
  final String password;
  final String confirmPassword;
  final Status status;

  SignupState copyWith({
    String? email,
    String? name,
    String? password,
    String? confirmPassword,
    Status? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, name, password, confirmPassword, status];
}
