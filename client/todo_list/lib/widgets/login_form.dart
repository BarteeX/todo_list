import 'package:flutter/material.dart';
import 'package:todo_list/models/login_data.dart';

class LoginForm extends StatefulWidget {
  final void Function(LoginData loginData) onSubmit;

  LoginForm({
    this.onSubmit,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  FocusNode _usernameNode;
  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _usernameField(),
          _passwordField(),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: _usernameController,
      focusNode: _usernameNode,
      validator: (value) {
        if (value.isEmpty) {
          return "Proszę podać nazwę użytkownika";
        }
        return null;
      },
      onFieldSubmitted: (_) {
        _usernameNode.nextFocus();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Login",
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      focusNode: _passwordNode,
      controller: _passwordController,
      obscureText: _obscurePassword,
      validator: (value) {
        if (value.isEmpty) {
          return "Proszę podać nazwę hasło";
        }
        return null;
      },
      onFieldSubmitted: (_) => _submitForm(),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: _obscureButton(),
        labelText: "Hasło",
      ),
    );
  }

  Widget _obscureButton() {
    return IconButton(
      icon: _obscureIcon(),
      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
    );
  }

  Icon _obscureIcon() {
    return Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off);
  }

  Widget _loginButton() {
    return FlatButton(
      child: Text("ZALOGUJ"),
      onPressed: _submitForm,
    );
  }

  void _submitForm() {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      LoginData loginData = LoginData(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      widget.onSubmit(loginData);
    }
  }
}
