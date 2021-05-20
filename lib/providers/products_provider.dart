import 'package:flutter/foundation.dart';
import 'package:flutter_course_1/model/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  var _showFavoritesOnly = false;

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get favoriteProducts =>
      List.unmodifiable(_products.where((e) => e.isFavorite).toList());

  void _addProduct(Product product) {
    _products.add(product.copyWith(
      id: DateTime.now().toString(),
    ));
    notifyListeners();
  }

  void addOrUpdateProduct(Product product) {
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _products[index] = product.copyWith();
    } else {
      _addProduct(product);
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
