
abstract class LoginEvent {}

class LoginFieldsChangedEvent extends LoginEvent {
  LoginFieldsChangedEvent(this.label, this.value);

  final String label;
  final String value;
}

class LoginClickedEvent extends LoginEvent {

  LoginClickedEvent();
}
