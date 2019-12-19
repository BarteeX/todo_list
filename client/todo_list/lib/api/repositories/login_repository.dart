import 'package:todo_list/api/providers/login_provider.dart';
import 'package:todo_list/models/login_answer.dart';
import 'package:todo_list/models/login_data.dart';

class LoginRepository {
  final LoginProvider _loginProvider;

  LoginRepository({
    LoginProvider loginProvider,
  }) : _loginProvider = loginProvider ?? LoginProvider();

  Future<LoginAnswer> loginAttempt(LoginData loginData) async {
    String username = loginData.username;
    String password = loginData.password;
    bool success = await _loginProvider.attempt(username, password);
    if (success) {
      return LoginAnswer(success: true);
    } else {
      return LoginAnswer(message: 'Błędne dane logowania');
    }
  }
}
