import 'package:todo_list/api/providers/todo_provider.dart';
import 'package:todo_list/models/todo_item.dart';

class TodoRepository {
  final TodoProvider _provider;

  TodoRepository({
    TodoProvider todoProvider,
  }) : _provider = todoProvider ?? TodoProvider();

  Future<List<TodoItem>> read() async {
    List<dynamic> data = await _provider.read();
    return data
        .map((dynamic item) => TodoItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<TodoItem> create(TodoItem todoItem) async {
    Map<String, dynamic> data = await _provider.create(
      topic: todoItem.topic,
      content: todoItem.content,
      date: todoItem.date,
    );
    return TodoItem.fromJson(data);
  }

  Future<TodoItem> update(TodoItem todoItem) async {
    Map<String, dynamic> data = await _provider.update(
      id: todoItem.id,
      topic: todoItem.topic,
      content: todoItem.content,
      date: todoItem.date,
    );
    return TodoItem.fromJson(data);
  }

  Future<void> delete(TodoItem todoItem) async {
    await _provider.delete(id: todoItem.id);
  }
}
