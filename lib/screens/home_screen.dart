import 'package:codeonce/models/User.dart';
import 'package:codeonce/screens/add_product_screen.dart';
import 'package:codeonce/screens/login_screen.dart';
import 'package:codeonce/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _logout() async {
    var _userService = UserService();
    var registeredUser = await _userService.logout();
    var result = json.decode(registeredUser.body);
  }

  _deleteUser(String username) async {
    var _userService = UserService();
    var registeredUser = await _userService.deleteUser(username);
    var result = json.decode(registeredUser.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  _ActivateUser(String username) async {
    var _userService = UserService();
    var registeredUser = await _userService.activateUser(username);
    var result = json.decode(registeredUser.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  List<User> _allUsers = <User>[];

  _getUsers() async {
    var _userService = UserService();
    var allUsers = await _userService.allUsers();
    var result = json.decode(allUsers.body);
    var log = new Logger();
    log.d(result);
    _allUsers.clear();

    result.forEach((data) {
      if (!data['enabled']) {
        var user = User();
        user.firstname = data['firstname'].toString();
        user.lastname = data['lastname'].toString();
        user.username = data['username'].toString();
        user.email = data['email'].toString();
        user.phone = data['phone'].toString();

        setState(() {
          _allUsers.add(user);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Grizzly API Starter",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          centerTitle: true,
          backgroundColor: Colors.lightBlue),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .lightBlue, //This will change the drawer background to blue.
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image(
                      image: AssetImage('logo.png'),
                      color: Colors.blueAccent,
                    )),
                ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text('Products List',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text('Add Product',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProduct()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      _logout();
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }),
              ],
            ),
          )),
      body: ListView.builder(
          itemCount: _allUsers.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Email: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allUsers[index].email}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Username: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allUsers[index].username}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          FloatingActionButton.extended(
                            onPressed: () {
                              _ActivateUser(_allUsers[index].username);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                            },
                            label: const Text('Approve'),
                            icon: const Icon(Icons.thumb_up),
                            backgroundColor: Colors.green,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              _deleteUser(_allUsers[index].username);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                            },
                            label: const Text('Delete'),
                            icon: const Icon(Icons.delete),
                            backgroundColor: Colors.pink,
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ),
            );
          }),
    );
  }
}
