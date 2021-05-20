import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> toggleFavorite() async {
    // optimistic update
    this._isFavorite = !this.isFavorite;
    notifyListeners();

    // now do request
    final url = Uri.parse(
        'https://flutter-shop-app-38383-default-rtdb.firebaseio.com/products/$id.json');

    final response = await http.patch(
      url,
      body: json.encode({'isFavorite': isFavorite}),
    );
    if (response.statusCode >= 400) {
      this._isFavorite = !this.isFavorite;
      notifyListeners();
    }
  }

  Product copyWith({
    String id,
    String title,
    String description,
    double price,
    String imageUrl,
    bool isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
