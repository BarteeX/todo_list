import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_event.dart';
import 'package:todo_list/blocs/todo_bloc/todo_state.dart';
import 'package:todo_list/pages/new_todo_page.dart';
import 'package:todo_list/widgets/todo_list.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TodoPage();
  }
}

class _TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<_TodoPage> {
  TodoBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc();
    _todoBloc.add(ReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO List"),
      ),
      body: BlocProvider<TodoBloc>(
        create: (context) => _todoBloc,
        child: BlocBuilder<TodoBloc, TodoState>(
          bloc: _todoBloc,
          condition: (previous, actual) => actual is ListUpdateState,
          builder: (context, state) {
            if (state is ListUpdateState) {
              return TodoList(
                todoItems: state.todoItemsList,
              );
            }

            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<TodoBloc>.value(
                child: NewTodoPage(),
                value: _todoBloc,
              ),
            ),
          );
        },
      ),
    );
  }
}
