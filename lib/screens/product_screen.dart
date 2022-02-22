import 'package:codeonce/models/Product.dart';
import 'package:codeonce/screens/home_screen.dart';
import 'package:codeonce/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import '../services/auth_service.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  _logout() async {
    var _userService = UserService();
    var registeredUser = await _userService.logout();
    var result = json.decode(registeredUser.body);
  }

  _deleteProduct(String id) async {
    var _productService = ProductService();
    var product = await _productService.deleteProduct(id);
    var result = json.decode(product.body);
    /*Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));*/
  }

  List<Product> _allProducts = <Product>[];
  List<Product> _sortedProducts = <Product>[];

  _getProducts() async {
    var _productService = ProductService();
    var allProducts = await _productService.allProducts();
    var result = json.decode(allProducts.body);
    var log = new Logger();
    result.forEach((data) {
      var product = Product();
      product.title = data['title'].toString();
      product.description = data['description'].toString();
      product.price = data['price'].toString();
      product.quantity = data['quantity'].toString();
      product.id = data['_id'].toString();

      setState(() {
        _allProducts.add(product);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
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
                    title: Text('Manage Users',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
          itemCount: _allProducts.length,
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
                            "title: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allProducts[index].title}',
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
                            "description: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allProducts[index].description}',
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
                            "Quantity: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allProducts[index].quantity}',
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
                            "Price: ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '${_allProducts[index].price}',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditScreen(_allProducts[index])));
                            },
                            label: const Text('Edit'),
                            icon: const Icon(Icons.edit),
                            backgroundColor: Colors.green,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              _deleteProduct(_allProducts[index].id);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductScreen()));
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
