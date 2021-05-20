import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  Product.empty()
      : id = "-1",
        title = "",
        description = "",
        price = 0,
        imageUrl = "";

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

  Product copyWith(
      {String id,
      String title,
      String description,
      double price,
      String imageUrl}) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: this.isFavorite,
    );
  }
}
