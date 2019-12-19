import 'package:bloc/bloc.dart';
import 'package:todo_list/api/repositories/todo_repository.dart';
import 'package:todo_list/blocs/todo_bloc/todo_event.dart';
import 'package:todo_list/blocs/todo_bloc/todo_state.dart';
import 'package:todo_list/models/todo_item.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc({
    TodoRepository todoRepository,
  }) : _repository = todoRepository ?? TodoRepository();

  @override
  TodoState get initialState => InitialState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is ReadEvent) {
      List<TodoItem> todoItemsList = await _repository.read();
      yield ListUpdateState(todoItemsList: todoItemsList);
    } else if (event is UpdateEvent) {
      TodoItem toUpdate = event.todoItem;
      TodoItem todoItem = await _repository.update(toUpdate);
      yield SingleUpdateState(todoItem: todoItem);
    } else if (event is DeleteEvent) {
      TodoItem toUpdate = event.todoItem;
      await _repository.delete(toUpdate);
    } else if (event is CreateEvent) {
      TodoItem toUpdate = event.todoItem;
      TodoItem todoItem = await _repository.create(toUpdate);
      yield SingleUpdateState(todoItem: todoItem);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(this);
    print(error);
    print(stacktrace);
  }
}
