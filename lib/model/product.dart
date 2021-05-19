import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    bool isFavorite = false,
  }) : _isFavorite = isFavorite;

  void toggleFavorite() {
    this._isFavorite = !this.isFavorite;
    notifyListeners();
  }
}
