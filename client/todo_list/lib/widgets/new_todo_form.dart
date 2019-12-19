import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_event.dart';
import 'package:todo_list/models/todo_item.dart';

class NewTodoForm extends StatefulWidget {
  @override
  _NewTodoFormState createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {
  TextEditingController _topicController;
  TextEditingController _contentController;
  TextEditingController _dateController;
  FocusNode _topicNode;
  FocusNode _contentNode;
  FocusNode _dateNode;

  DateTime _dateValue;

  @override
  void initState() {
    super.initState();
    _topicController = new TextEditingController();
    _contentController = new TextEditingController();
    _dateController = new TextEditingController();
    _topicNode = new FocusNode();
    _contentNode = new FocusNode();
    _dateNode = new FocusNode();
    _dateValue = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _topicField(),
          _contentField(),
          _dateField(),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _topicField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Temat"),
      controller: _topicController,
      focusNode: _topicNode,
      onFieldSubmitted: (_) => _topicNode.nextFocus(),
    );
  }

  Widget _contentField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Kontent"),
      controller: _contentController,
      focusNode: _contentNode,
      onFieldSubmitted: (_) => _contentNode.nextFocus(),
    );
  }

  Widget _dateField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Data",
        suffixIcon: IconButton(
          icon: Icon(
            Icons.date_range,
            color: Colors.black,
          ),
          onPressed: () async {
            DateTime date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.utc(2000),
              lastDate: DateTime.utc(2050),
            );
            if (date != null) {
              _dateValue = date;
              _dateController.text = date.toIso8601String().split('T')[0];
            }
          },
        ),
      ),
      controller: _dateController,
      focusNode: _dateNode,
      onFieldSubmitted: (_) => _submitForm(),
    );
  }

  Widget _submitButton() {
    return FlatButton(
      child: Text("ZAPISZ"),
      onPressed: _submitForm,
    );
  }

  void _submitForm() {
    TodoItem item = TodoItem(
      topic: _topicController.text,
      content: _contentController.text,
      date: _dateValue,
    );

    CreateEvent event = CreateEvent(todoItem: item);

    TodoBloc bloc = BlocProvider.of<TodoBloc>(context);
    bloc.add(event);
    bloc.add(ReadEvent());
    Navigator.pop(context);
  }
}
