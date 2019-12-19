abstract class LoginState {}

class InitialState extends LoginState {}

class SuccessState extends LoginState {}

class FailureState extends LoginState {
  final String msg;

  FailureState({this.msg = ''});
}
