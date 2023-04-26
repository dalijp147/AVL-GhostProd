import 'package:flutter/material.dart';
import 'package:ghost_prod/provider/cart_provider.dart';
import 'package:ghost_prod/provider/event_provider.dart';
import 'package:ghost_prod/provider/product_provider.dart';
import 'package:ghost_prod/screens/detailScreen.dart';
import 'package:ghost_prod/screens/favoriteScreen.dart';
import 'package:ghost_prod/screens/homepage.dart';
import 'package:ghost_prod/widget/tab_widget.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';

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
