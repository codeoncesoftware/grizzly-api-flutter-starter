import 'package:codeonce/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

String _baseUrl = 'https://app.grizzly-api.com/runtime/<your_version_id>/';

class UserService {
  UserService() {}
  var token;

  login(String username, String password) async {
    return await http.post('${_baseUrl}signin',
        body: jsonEncode({'username': username, 'password': password}));
  }

  register(User user) async {
    return await http.post('${_baseUrl}signup', body: jsonEncode(user));
  }

  logout() async {
    return await http.get('${_baseUrl}logout');
  }

  deleteUser(String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');

    return await http.delete('${_baseUrl}deleteuser?username=${username}',
        headers: {'Authorization': 'Bearer $token'});
  }

  getUser(String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
    return await http.get('${_baseUrl}user?username=${username}',
        headers: {'Authorization': 'Bearer $token'});
  }

  me() async {
    return await http.get('${_baseUrl}me');
  }

  allUsers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');

    return await http.get('${_baseUrl}allusers',
        headers: {'Authorization': 'Bearer $token'});
  }

  activateUser(String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
    return await http.post('${_baseUrl}activate?username=${username}',
        headers: {'Authorization': 'Bearer $token'});
  }

  updateUser(User user) async {
    return await http.put('${_baseUrl}updateuser?username=${user.username}',
        body: jsonEncode(user), headers: {'Authorization': 'Bearer $token'});
  }
}
