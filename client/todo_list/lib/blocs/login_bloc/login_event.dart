import 'package:equatable/equatable.dart';
import 'package:todo_list/models/login_data.dart';

abstract class LoginEvent extends Equatable {
  final List data;

  LoginEvent([this.data = const []]) : super();

  @override
  List<Object> get props => data;
}

class LoginAttempt extends LoginEvent {
  final LoginData loginData;

  LoginAttempt({this.loginData}) : super([loginData]);
}
