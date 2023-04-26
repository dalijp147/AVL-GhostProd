// ignore_for_file: prefer_const_constructors

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghost_prod/screens/cartScreen.dart';
import 'package:ghost_prod/screens/favoriteScreen.dart';
import 'package:ghost_prod/screens/homepage.dart';
import 'package:ghost_prod/screens/productScreen.dart';
import 'package:ghost_prod/screens/profile.dart';
import 'package:iconsax/iconsax.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  String title = 'BottomNavigationBar';

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            ProductScreen(),
            FavoriteScreen(),
            profile(),
          ],
          // If you want to disable swiping in tab the use below code
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: Container(
              color: Color.fromARGB(255, 26, 26, 26),
              child: TabBar(
                labelColor: Color.fromARGB(255, 39, 152, 183),
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 10.0),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color.fromARGB(137, 0, 0, 0)),
                ),
                //For Indicator Show and Customization
                indicatorColor: Colors.black54,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Iconsax.home,
                      size: 24.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Iconsax.shopping_bag,
                      size: 24.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Iconsax.heart,
                      size: 24.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Iconsax.user,
                      size: 24.0,
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ));
  }
}
