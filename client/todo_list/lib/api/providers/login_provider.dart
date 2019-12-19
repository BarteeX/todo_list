import 'package:todo_list/api/data_provider.dart';

class LoginProvider {
  final DataProvider _provider;

  LoginProvider({
    DataProvider provider,
  }) : _provider = provider ?? DataProvider();

  Future<bool> attempt(String username, String password) async {
    Map<String, String> data = {
      'username': username,
      'password': password,
    };
    Map<String, dynamic> response = await _provider.post('login', data);
    return response['success'];
  }
}
