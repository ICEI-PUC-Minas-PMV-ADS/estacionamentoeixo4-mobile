
abstract class SignupEvent {}

class SignupFieldsChangedEvent extends SignupEvent {
  SignupFieldsChangedEvent(this.label, this.value);

  final String label;
  final String value;
}

class SignupClickedEvent extends SignupEvent {
  SignupClickedEvent();
}
