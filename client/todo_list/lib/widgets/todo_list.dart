import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoList extends StatefulWidget {
  final List<TodoItem> todoItems;

  TodoList({Key key, this.todoItems}) : super(key: key);

  @override
  _TodoListState createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> get _items => widget.todoItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        TodoItem todoItem = _items[index];
        return TodoListItem(
          todoItem: todoItem,
        );
      },
    );
  }
}
