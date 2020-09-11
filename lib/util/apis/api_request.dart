import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIRequest {
  static String baseUrl = 'https://flutter-dayshop.firebaseio.com/';
  static String productsEndPoint = '/products.json';

  static Future<http.Response> postNewProduct(Map<String, dynamic> param) {
    Map<String, dynamic> body = {
      'title': param['title'],
      'price': param['price'],
      'description': param['description'],
      'imageUrl': param['imageUrl'],
    };
    return http.post('$baseUrl$productsEndPoint', body: json.encode(body));
  }
}
