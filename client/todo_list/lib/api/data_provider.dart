import 'dart:convert';

import 'package:http/http.dart';

class DataProvider {
  static DataProvider _instance;

  final String _server = 'http://172.20.2.133:3000/';
  final Client client;

  DataProvider._internal() : this.client = Client();

  factory DataProvider() {
    if (_instance == null) {
      _instance = DataProvider._internal();
    }
    return _instance;
  }

  Future<Map<String, dynamic>> get(String url) async {
    Response response = await client.get(_server + url);
    String body = response.body;
    return json.decode(body);
  }

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> data,
  ) async {
    Response response = await client.post(_server + url, body: data);
    String body = response.body;
    return json.decode(body);
  }

  Future<Map<String, dynamic>> delete(
    String url,
    String data,
  ) async {
    Response response = await client.delete(
      _server + url,
      headers: {
        "data": data,
      },
    );
    String body = response.body;
    return json.decode(body);
  }
}
