import 'package:equatable/equatable.dart';

enum Status { initial, valid, invalid, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.status = Status.initial,
  });

  final String email;
  final String password;
  final Status status;

  LoginState copyWith({
    String? email,
    String? password,
    Status? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}
