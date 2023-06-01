import 'package:flutter/widgets.dart';

abstract class LoginEvent {}

class LoginFieldsChangedEvent extends LoginEvent {
  LoginFieldsChangedEvent(this.label, this.value);

  final String label;
  final String value;
}

class LoginClickedEvent extends LoginEvent {
  final BuildContext context;

  LoginClickedEvent(this.context);
}
