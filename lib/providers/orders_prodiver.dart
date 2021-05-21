import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_course_1/providers/cart_prodiver.dart';

import 'package:http/http.dart' as http;

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
  static const BASE_URL =
      'https://flutter-shop-app-38383-default-rtdb.firebaseio.com/';

  final String authToken;
  final String userId;
  List<OrderItem> _orders = [];

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders => [..._orders];

  Map<String, dynamic> toMap(CartItem item) => {
        'id': item.id,
        'title': item.title,
        'price': item.price,
        'quantity': item.quantity,
      };

  CartItem _parseCartItem(dynamic item) => CartItem(
        id: item['id'],
        title: item['title'],
        quantity: item['quantity'],
        price: item['price'],
      );

  Future<void> loadOrders() async {
    final url = Uri.parse('$BASE_URL/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);

    if (response.statusCode >= 400)
      return Future.error('Failed loading orders');

    final map = json.decode(response.body) as Map<String, dynamic>;

    _orders = map.entries
        .map((e) => OrderItem(
              id: e.key,
              amount: e.value['amount'],
              products: (e.value['products'] as List<dynamic>)
                  .map(_parseCartItem)
                  .toList(),
              dateTime: DateTime.parse(e.value['dateTime']),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse('$BASE_URL/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts.map(toMap).toList(),
      }),
    );

    if (response.statusCode < 400) {
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } else {
      return Future.error('Failed to create order');
    }
  }
}
