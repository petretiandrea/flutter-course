import 'package:flutter/foundation.dart';
import 'package:flutter_course_1/providers/orders_prodiver.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  CartItem increaseQuantity({int by = 1}) {
    return CartItem(
      id: id,
      title: title,
      quantity: quantity + by,
      price: price,
    );
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount =>
      _items.values.fold(0, (amount, _) => amount + (_.price * _.quantity));

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    final cartItem = _items.containsKey(productId)
        ? _items[productId].increaseQuantity(by: 1)
        : CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price,
          );

    _items[productId] = cartItem;

    notifyListeners();
  }

  void removeItem(String cartId) {
    _items.removeWhere((_, item) => item.id == cartId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
