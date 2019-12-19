import 'package:equatable/equatable.dart';

class LoginAnswer extends Equatable {
  final String message;
  final bool success;

  LoginAnswer({this.message = '', this.success = false});

  @override
  List<Object> get props => [message, success];
}
