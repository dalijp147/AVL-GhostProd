import 'package:map/Models/user.dart';
import 'package:flutter/material.dart';


import '../Models/navigation_item.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.Acceuil;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}
class NavigationProviderUser extends ChangeNotifier {
  AppUser _user = AppUser();

  AppUser get user => _user;

  void setCurrentUser(user) {
    _user = user;

    notifyListeners();
  }
}
