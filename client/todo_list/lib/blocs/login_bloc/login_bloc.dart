import 'package:bloc/bloc.dart';
import 'package:todo_list/api/repositories/login_repository.dart';
import 'package:todo_list/blocs/login_bloc/login_event.dart';
import 'package:todo_list/blocs/login_bloc/login_state.dart';
import 'package:todo_list/models/login_answer.dart';
import 'package:todo_list/models/login_data.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({
    LoginRepository loginRepository,
  }) : _loginRepository = loginRepository ?? LoginRepository();

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginAttempt) {
      LoginData data = event.loginData;
      LoginAnswer loginAnswer = await _loginRepository.loginAttempt(data);
      bool success = loginAnswer.success;
      if (success) {
        yield SuccessState();
      } else {
        String message = loginAnswer.message;
        yield FailureState(msg: message);
      }
    }
  }
}
