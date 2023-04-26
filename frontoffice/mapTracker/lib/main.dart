import 'package:flutter/material.dart';
import 'package:map/provider/favorite_provider.dart';
import 'package:map/provider/location_provider.dart';
import '../provider/cart_provider.dart';
import '../provider/event_provider.dart';
import '../provider/product_provider.dart';
import '../screen/detailScreen.dart';
import '../screen/favoriteScreen.dart';
import '../screen/homepage.dart';
import '../widget/tab_widget.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'provider/navigation_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (_) => EventProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider<NavigationProviderUser>(
          create: (_) => NavigationProviderUser(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider<Favoriteprovider>(
          create: (_) => Favoriteprovider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
        },
      ),
    );
  }
}
