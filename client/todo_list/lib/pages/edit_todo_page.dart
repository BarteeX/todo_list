import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/widgets/edit_todo_form.dart';

class EditTodoPage extends StatelessWidget {
  final TodoItem todoItem;

  const EditTodoPage({Key key, this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edytuj TODO"),
      ),
      body: EditTodoForm(
        todoItem: todoItem,
      ),
    );
  }
}
