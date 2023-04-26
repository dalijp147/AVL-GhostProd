import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/location.dart';

class LocationProvider with ChangeNotifier {
  List<LocationP> cart = [];
  List<LocationP> get locations => cart;

  void addLocation(LocationP location) {
    cart.add(location);
    notifyListeners();
    print(cart);
  }
}
