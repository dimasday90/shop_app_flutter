import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//* providers
import '../../providers/products.dart';
import '../../providers/cart.dart';

class APIRequest {
  static String baseUrl = 'https://flutter-dayshop.firebaseio.com/';
  static String firebaseAPIKey = 'AIzaSyBOOvsc39S6zcLcDmP6APK3OT6unRqjvpI';
  static String productsEndPoint = '/products.json';
  static String ordersEndPoint = '/orders';
  static String userFavoritesEndPoint = '/userFavorites';
  static String firebaseAuthEndPoint =
      'https://identitytoolkit.googleapis.com/v1';

  static Future<http.Response> signUp(String email, String password) {
    var param = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };

    return http.post('$firebaseAuthEndPoint/account:signUp?key=$firebaseAPIKey',
        body: json.encode(param));
  }

  static Future<http.Response> login(String email, String password) {
    var param = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };

    return http.post(
        '$firebaseAuthEndPoint/account:signInWithPassword?key=$firebaseAPIKey',
        body: json.encode(param));
  }

  static Future<http.Response> getProducts(
      String userId, String token, filterByUser) {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    return http.get('$baseUrl$productsEndPoint?auth=$token$filterString');
  }

  static Future<http.Response> getUserFavorites(String userId, String token) {
    return http.get('$baseUrl$userFavoritesEndPoint/$userId.json?auth=$token');
  }

  static Future<http.Response> postNewProduct(
      Map<String, dynamic> param, String token) {
    Map<String, dynamic> body = {
      'title': param['title'],
      'price': param['price'],
      'description': param['description'],
      'imageUrl': param['imageUrl'],
    };
    return http.post('$baseUrl$productsEndPoint?auth=$token',
        body: json.encode(body));
  }

  static Future<http.Response> patchProduct(
      String id, Product newData, String token) {
    Map<String, dynamic> body = {
      'title': newData.title,
      'price': newData.price,
      'description': newData.description,
      'imageUrl': newData.imageUrl,
    };
    return http.patch('$baseUrl/products/$id.json?auth=$token',
        body: json.encode(body));
  }

  static Future<http.Response> deleteProduct(String id, String token) {
    return http.delete('$baseUrl/products/$id.json?auth=$token');
  }

  static Future<http.Response> toogleFavorite(
      String id, String userId, bool favoriteStatus, String token) {
    return http.patch(
        '$baseUrl$userFavoritesEndPoint/$userId/$id.json?auth=$token',
        body: json.encode(favoriteStatus));
  }

  static Future<http.Response> getOrders(String userId, String token) {
    return http.get('$baseUrl$ordersEndPoint/$userId.json?auth=$token');
  }

  static Future<http.Response> addOrder(List<CartItem> cartProducts,
      double total, DateTime timestamp, String userId, String token) {
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

    return http.post('$baseUrl$ordersEndPoint/$userId.json?auth=$token',
        body: param);
  }
}
