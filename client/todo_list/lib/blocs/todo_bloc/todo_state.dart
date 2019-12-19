import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo_item.dart';

abstract class TodoState extends Equatable {
  final List _data;

  TodoState([List props = const []]) : _data = props;

  @override
  List<Object> get props => _data;
}

class InitialState extends TodoState {}

class ListUpdateState extends TodoState {
  final List<TodoItem> todoItemsList;

  ListUpdateState({this.todoItemsList}) : super(todoItemsList);
}

class SingleUpdateState extends TodoState {
  final TodoItem todoItem;

  SingleUpdateState({this.todoItem}) : super([todoItem]);
}
