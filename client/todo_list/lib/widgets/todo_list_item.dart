import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_event.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/pages/edit_todo_page.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem todoItem;

  TodoListItem({Key key, this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Dismissible(
        key: Key(todoItem.id.toString()),
        onDismissed: (direction) {
          final TodoBloc bloc = BlocProvider.of<TodoBloc>(context);
          bloc.add(DeleteEvent(todoItem: todoItem));
        },
        child: GestureDetector(
          onTap: () {
            print("działa");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider<TodoBloc>.value(
                  value: BlocProvider.of<TodoBloc>(context),
                  child: EditTodoPage(
                    todoItem: todoItem,
                  ),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      todoItem.topic ?? '',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      todoItem.content ?? '',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Text(todoItem.date.toIso8601String().split("T")[0] ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
