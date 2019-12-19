import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo_item.dart';

abstract class TodoEvent extends Equatable {
  final List data;

  TodoEvent([this.data = const []]);

  @override
  List<Object> get props => data;
}

class ReadEvent extends TodoEvent {}

class DeleteEvent extends TodoEvent {
  final TodoItem todoItem;

  DeleteEvent({this.todoItem}) : super([todoItem]);
}

class CreateEvent extends TodoEvent {
  final TodoItem todoItem;

  CreateEvent({this.todoItem}) : super([todoItem]);
}

class UpdateEvent extends TodoEvent {
  final TodoItem todoItem;

  UpdateEvent({this.todoItem}) : super([todoItem]);
}
