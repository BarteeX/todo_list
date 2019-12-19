import 'package:todo_list/api/data_provider.dart';

class TodoProvider {
  final DataProvider _provider;

  TodoProvider({
    DataProvider dataProvider,
  }) : _provider = dataProvider ?? DataProvider();

  Future<List<dynamic>> read() async {
    Map<String, dynamic> response = await _provider.get('todo');
    return response['data'];
  }

  Future<Map<String, dynamic>> create({
    String topic,
    String content,
    DateTime date,
  }) async {
    Map<String, dynamic> data = {
      "topic": topic,
      "content": content,
      "date": date.toIso8601String(),
    };
    Map<String, dynamic> response = await _provider.post('todo', data);
    return response['item'];
  }

  Future<Map<String, dynamic>> update({
    int id,
    String topic,
    String content,
    DateTime date,
  }) async {
    Map<String, dynamic> data = {
      "id": id.toString(),
      "topic": topic,
      "content": content,
      "date": date.toIso8601String(),
    };
    Map<String, dynamic> response = await _provider.post('todo', data);
    return response['item'];
  }

  Future<void> delete({int id}) async {
    await _provider.delete('todo', id.toString());
  }
}
