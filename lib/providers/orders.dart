import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

//* provider's model
import './cart.dart';

//* utils
import '../util/apis/api_request.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String userId;
  final String authToken;

  Orders(this.userId, this.authToken, this._orders);

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchOrders() async {
    final response = await APIRequest.getOrders(userId, authToken);
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['created_at']),
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  imageUrl: item['imageUrl'],
                  quantity: item['quantity'],
                ))
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    final response = await APIRequest.addOrder(
        cartProducts, total, timestamp, userId, authToken);
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ));
    notifyListeners();
  }
}
