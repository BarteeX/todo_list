import 'package:flutter/material.dart';
import 'package:todo_list/widgets/new_todo_form.dart';

class NewTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nowe TODO"),
      ),
      body: NewTodoForm(),
    );
  }
}
