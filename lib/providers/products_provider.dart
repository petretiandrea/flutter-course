import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_course_1/model/product.dart';

import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  static const BASE_URL =
      'https://flutter-shop-app-38383-default-rtdb.firebaseio.com/';

  List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get favoriteProducts =>
      List.unmodifiable(_products.where((e) => e.isFavorite).toList());

  final String authToken;
  final String userId;

  ProductsProvider(this.authToken, this.userId, this._products);

  Future<void> loadProducts([bool filterByCreator = false]) async {
    try {
      // try to prevent overwrite when there is an error
      _products = await _fetchProducts(filterByCreator);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, bool>> _fetchFavorites() async {
    final url = Uri.parse(
        'https://flutter-shop-app-38383-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');

    final response = await http.get(url);
    final favoriteData = json.decode(response.body) as Map<String, dynamic>;

    if (favoriteData == null) return {};

    return favoriteData
        .map((key, value) => MapEntry(key, value['isFavorite'] as bool));
  }

  Future<List<Product>> _fetchProducts(bool filterByCreator) async {
    final filter =
        filterByCreator ? '&orderBy="creatorId"&equalTo="$userId"' : "";
    final url = Uri.parse('$BASE_URL/products.json?auth=$authToken$filter');
    final response = await http.get(url);
    final map = json.decode(response.body) as Map<String, dynamic>;
    final favorites = await _fetchFavorites();

    return map.entries
        .map((e) => Product(
              id: e.key,
              title: e.value['title'],
              description: e.value['description'],
              price: e.value['price'],
              imageUrl: e.value['imageUrl'],
              isFavorite: favorites.isEmpty ? false : favorites[e.key] ?? false,
              creatorId: e.value['creatorId'],
            ))
        .toList();
  }

  Future<void> _addProduct(Product product) async {
    final newProduct = product.copyWith(creatorId: userId);
    final url = Uri.parse('$BASE_URL/products.json?auth=$authToken');
    final response = await http.post(url, body: json.encode(toMap(newProduct)));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonBody = json.decode(response.body);
      _products.add(newProduct.copyWith(id: jsonBody['name']));
      notifyListeners();
      return;
    }

    return Future.error('Error during creation of product');
  }

  Map<String, Object> toMap(Product product) => {
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'creatorId': product.creatorId
      };

  Future<void> addOrUpdateProduct(Product product) async {
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      final url =
          Uri.parse('$BASE_URL/products/${product.id}.json?auth=$authToken');
      final response = await http.patch(url,
          body: json.encode(toMap(product.copyWith(isFavorite: false))));

      print(response.toString());
      if (response.statusCode == 200) {
        _products[index] = product.copyWith();
        notifyListeners();
      }
    } else {
      return _addProduct(product);
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse('$BASE_URL/products/$id.json?auth=$authToken');

    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        return Future.error('Could not delete product');
      }
      _products.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
