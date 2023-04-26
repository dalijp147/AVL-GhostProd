import 'package:flutter/material.dart';
import 'package:map/Models/product.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/favorite.dart';
import '../Models/dbfavorite.dart';

class Favoriteprovider with ChangeNotifier {
  DBFavorite dbFavorite = DBFavorite();
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  List<Favorite> fav = [];
  List<Product> prod = [];
  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);

    notifyListeners();
  }

  Future<List<Favorite>> getData() async {
    fav = await dbFavorite.getCartList();
    notifyListeners();
    return fav;
  }

  void removeItem(int id) {
    final index = fav.indexWhere((element) => element.id == id);
    fav.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  void toggle(Favorite id) {
    final isExist = fav.contains(id);
    if (isExist) {
      fav.remove(id);
    } else {
      fav.add(id);
    }
    notifyListeners();
  }

  bool isExist(int id) {
    final isExist = fav.contains(id);
    if (isExist == true) {
      return true;
    } else {
      return false;
    }
  }
}
