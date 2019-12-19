import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_list/blocs/todo_bloc/todo_event.dart';
import 'package:todo_list/models/todo_item.dart';

class EditTodoForm extends StatefulWidget {
  final TodoItem todoItem;

  const EditTodoForm({Key key, this.todoItem}) : super(key: key);

  @override
  _EditTodoFormState createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {
  TextEditingController _topicController;
  TextEditingController _contentController;
  TextEditingController _dateController;
  FocusNode _topicNode;
  FocusNode _contentNode;
  FocusNode _dateNode;

  DateTime _dateValue;

  TodoItem get _item => widget.todoItem;

  @override
  void initState() {
    super.initState();
    _topicController = new TextEditingController(text: _item.topic);
    _contentController = new TextEditingController(text: _item.content);
    _dateController = new TextEditingController(
        text: _item.date.toIso8601String().split('T')[0]);
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
      id: _item.id,
      topic: _topicController.text,
      content: _contentController.text,
      date: _dateValue,
    );

    UpdateEvent event = UpdateEvent(todoItem: item);

    TodoBloc bloc = BlocProvider.of<TodoBloc>(context);
    bloc.add(event);
    bloc.add(ReadEvent());
    Navigator.pop(context);
  }
}
