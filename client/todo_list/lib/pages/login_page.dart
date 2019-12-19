import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/login_bloc/login_bloc.dart';
import 'package:todo_list/blocs/login_bloc/login_event.dart';
import 'package:todo_list/blocs/login_bloc/login_state.dart';
import 'package:todo_list/pages/todo_page.dart';
import 'package:todo_list/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zaloguj się"),
      ),
      body: _LoginPageBody(
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoPage(),
            ),
          );
        },
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  final void Function() onSuccess;

  _LoginPageBody({this.onSuccess});

  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  LoginBloc _bloc;
  String _loginErrorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
    _loginErrorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _bloc,
      listener: (BuildContext context, LoginState state) {
        if (state is SuccessState) {
          widget.onSuccess();
          _loginErrorMessage = '';
        } else if (state is FailureState) {
          String message = state.msg;
          _loginErrorMessage = message;
        }

        setState(() {});
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appNameWidget(),
              LoginForm(
                onSubmit: (loginData) {
                  LoginAttempt event = LoginAttempt(
                    loginData: loginData,
                  );
                  _bloc.add(event);
                },
              ),
              if (_loginErrorMessage.isNotEmpty)
                Text(
                  _loginErrorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appNameWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: Text(
        "TODO List",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
