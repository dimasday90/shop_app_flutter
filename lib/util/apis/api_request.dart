import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//* providers
import '../../providers/products.dart';
import '../../providers/cart.dart';

class APIRequest {
  static String baseUrl = 'https://flutter-dayshop.firebaseio.com/';
  static String productsEndPoint = '/products.json';
  static String ordersEndPoint = '/orders.json';

  static Future<http.Response> getProducts() {
    return http.get('$baseUrl$productsEndPoint');
  }

  static Future<http.Response> postNewProduct(Map<String, dynamic> param) {
    Map<String, dynamic> body = {
      'title': param['title'],
      'price': param['price'],
      'description': param['description'],
      'imageUrl': param['imageUrl'],
      'isFavorite': param['isFavorite'],
    };
    return http.post('$baseUrl$productsEndPoint', body: json.encode(body));
  }

  static Future<http.Response> patchProduct(String id, Product newData) {
    Map<String, dynamic> body = {
      'title': newData.title,
      'price': newData.price,
      'description': newData.description,
      'imageUrl': newData.imageUrl,
    };
    return http.patch('$baseUrl/products/$id.json', body: json.encode(body));
  }

  static Future<http.Response> deleteProduct(String id) {
    return http.delete('$baseUrl/products/$id.json');
  }

  static Future<http.Response> toogleFavorite(
      String id, Map<String, bool> favoriteBody) {
    return http.patch('$baseUrl/products/$id.json',
        body: json.encode(favoriteBody));
  }

  static Future<http.Response> getOrders() {
    return http.get('$baseUrl$ordersEndPoint');
  }

  static Future<http.Response> addOrder(
      List<CartItem> cartProducts, double total, DateTime timestamp) {
    var param = json.encode({
      "amount": total,
      "created_at": timestamp.toIso8601String(),
      'products': cartProducts
          .map((prod) => {
                "id": prod.id,
                "title": prod.title,
                "quantity": prod.quantity,
                "price": prod.price,
                "imageUrl": prod.imageUrl,
              })
          .toList(),
    });

    return http.post('$baseUrl$ordersEndPoint', body: param);
  }
}
