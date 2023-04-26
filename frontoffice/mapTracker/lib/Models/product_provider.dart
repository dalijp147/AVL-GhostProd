import 'package:flutter/material.dart';

import '../Models/product.dart';

class Products with ChangeNotifier {
    List<Product> products = List<Product>.empty(growable: true);

  List<Product> items = [];
  List<Product> _itemf = [];
  List<Product> get itemfs => _itemf;

  List<Product> get itemss {
    return [...items];
  }

  List<Product> get favoriteItems {
    return items.where((prodItem) => prodItem.isFavourite!).toList();
  }

  Product findById(int id) {
    return products.firstWhere((prod) => prod.id == id);
  }

  void toggle(Product item) {
    final isExist = _itemf.contains(item);
    if (isExist) {
      _itemf.remove(item);
    } else {
      _itemf.add(item);
    }
    notifyListeners();
  }

  bool isExist(Product item) {
    final isExist = _itemf.contains(item);
    return isExist;
  }

  void clearFav() {
    items = [];
    notifyListeners();
  }
}
