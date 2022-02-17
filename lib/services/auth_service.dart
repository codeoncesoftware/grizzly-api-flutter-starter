import 'package:codeonce/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

String _baseUrl =
    'https://app.grizzly-api.com/runtime/6201ae441615636a09a5c0e9/';

class UserService {
  UserService() {}

  login(String username, String password) async {
    return await http.post('${_baseUrl}signin',
        body: jsonEncode({'username': username, 'password': password}));
  }

  register(User user) async {
    return await http.post('${_baseUrl}signup', body: jsonEncode(user));
  }
}
