import 'package:codeonce/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

String _baseUrl =
    'https://app.grizzly-api.com/runtime/620faa841da35156832fd69c/';

class ProductService {
  ProductService() {}
  addProduct(Product product) async {
    return await http.post('${_baseUrl}addproduct', body: jsonEncode(product));
  }

  deleteProduct(String id) async {
    return await http.delete('${_baseUrl}deleteproduct/${id}');
  }

  allProducts() async {
    return await http.get('${_baseUrl}allproducts');
  }

  updateProduct(Product product) async {
    return await http.put('${_baseUrl}editproduct/${product.id}',
        body: jsonEncode(product));
  }
}
