// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:map/screen/notificationlist.dart';
import '../Models/dbhelper.dart';
import '../Models/product.dart';
import '../screen/cartScreen.dart';
import '../screen/historyscreen.dart';
import '../screen/productScreen.dart';

import '../widget/product_overview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import 'home.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgColor = Colors.yellow;
  Product? product;
  String dropdownvalue = 'Sony';
  String dropdownvalueSize = '4.5 inches';
  String dropdownvaluePrice = '300 Dt';

  // List of items in our dropdown menu
  var items = [
    'Sony',
    'Canon',
    'equipement',
  ];
  var size = [
    '4.5 inches',
    '5 inches',
    '10 inches',
  ];
  var price = [
    '300 Dt',
    '400 Dt',
    '250 Dt',
  ];
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'camera',
      'iconPath': 'assets/images/iconcam.png',
    },
  ];
  int currentindex = 0;
  String _searchQuery = '';
  final TextEditingController _nameController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 100);
  double _minPrice = 0;
  double _maxPrice = 100;
  List<Product> _products = [];
  @override
  void initState() {
    super.initState();
    _nameController.text =
        ''; // set the initial value of the name field to an empty string
  }

  @override
  void dispose() {
    _nameController.dispose(); // dispose of the text editing controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context).items;
    Iterable<Product> prod = Provider.of<Products>(context).itemss;
    int _index = 0;
    final controller = TextEditingController();
    void updateList(String value) {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Iconsax.shopping_cart)),
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationList(),
                ),
              );
            },
            icon: Icon(Iconsax.notification),
          ),
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductSearch(),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.history,
              ),
              title: const Text('historique de commande'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HPage(),
                        ),
                      );
                    },
                    child: Text("filtrer",
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Color.fromARGB(255, 30, 117, 141),
                            fontWeight: FontWeight.bold))),
              ],
            ),
            // Row(
            //   children: [
            //     Text("Selectionner category",
            //         style: GoogleFonts.barlow(
            //             fontWeight: FontWeight.bold, fontSize: 23)),
            //     Spacer(
            //       flex: 2,
            //     ),
            //     TextButton(
            //         onPressed: () {},
            //         child: Text("Voir tous",
            //             style: GoogleFonts.lato(
            //                 fontSize: 15,
            //                 color: Color.fromARGB(255, 30, 117, 141),
            //                 fontWeight: FontWeight.bold)))
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 100,
            //   child: ListView.separated(
            //     itemCount: categories.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               setState(() {
            //                 currentindex = index;
            //               });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(50),
            //                   color: currentindex == index
            //                       ? Color.fromARGB(255, 39, 152, 183)
            //                       : Colors.white),
            //               height: 60,
            //               width: 60,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Image.asset(
            //                   categories[index]["iconPath"],
            //                   height: 10,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           Text("${categories.elementAt(index)["name"]}")
            //         ],
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) => SizedBox(
            //       width: 20,
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => HPage(),
            //           ),
            //         );
            //         // showModalBottomSheet(
            //         //   context: context,
            //         //   backgroundColor: Colors.white,
            //         //   shape: RoundedRectangleBorder(
            //         //     borderRadius: BorderRadiusDirectional.only(
            //         //       topEnd: Radius.circular(25),
            //         //       topStart: Radius.circular(25),
            //         //     ),
            //         //   ),
            //         //   builder: (BuildContext context) {
            //         //     return Container(
            //         //       padding: EdgeInsetsDirectional.only(
            //         //         start: 20,
            //         //         end: 20,
            //         //         bottom: 30,
            //         //         top: 8,
            //         //       ),
            //         //       child: Column(
            //         //         children: [
            //         //           Row(
            //         //             mainAxisAlignment:
            //         //                 MainAxisAlignment.spaceBetween,
            //         //             children: [
            //         //               IconButton(
            //         //                 iconSize: 37,
            //         //                 onPressed: () {
            //         //                   Navigator.pop(context);
            //         //                 },
            //         //                 icon: Icon(Iconsax.close_square5),
            //         //               ),
            //         //               Text(
            //         //                 "Option de filtrage",
            //         //                 style: TextStyle(
            //         //                     fontWeight: FontWeight.bold,
            //         //                     fontSize: 19),
            //         //               ),
            //         //               SizedBox(
            //         //                 width: 86,
            //         //                 height: 37,
            //         //                 child: ElevatedButton(
            //         //                     style: ElevatedButton.styleFrom(
            //         //                       primary:
            //         //                           Color.fromARGB(255, 30, 117, 141),
            //         //                       shape: RoundedRectangleBorder(
            //         //                         borderRadius: BorderRadius.circular(
            //         //                             12), // <-- Radius
            //         //                       ),
            //         //                     ),
            //         //                     onPressed: () {},
            //         //                     child: Text('fait')),
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           SizedBox(
            //         //             height: 30,
            //         //           ),
            //         //           Padding(
            //         //             padding: const EdgeInsets.all(30.0),
            //         //             child: Container(
            //         //               child: Column(
            //         //                 children: [
            //         //                   Text('Name'),
            //         //                   TextField(
            //         //                     controller: _nameController,
            //         //                     decoration: InputDecoration(
            //         //                       hintText: 'Enter product name',
            //         //                     ),
            //         //                   ),
            //         //                   SizedBox(height: 16),
            //         //                   Text('Price range'),
            //         //                   RangeSlider(
            //         //                     values: _priceRange,
            //         //                     min: _minPrice,
            //         //                     max: _maxPrice,
            //         //                     onChanged: (values) {
            //         //                       setState(() {
            //         //                         _priceRange = values;
            //         //                       });
            //         //                     },
            //         //                     divisions:
            //         //                         (_maxPrice - _minPrice).toInt(),
            //         //                     labels: RangeLabels(
            //         //                       _priceRange.start.toString(),
            //         //                       _priceRange.end.toString(),
            //         //                     ),
            //         //                   ),
            //         //                   SizedBox(height: 16),
            //         //                 ],
            //         //               ),
            //         //             ),
            //         //           )
            //         //         ],
            //         //       ),
            //         //     );
            //         //   },
            //         // );
            //       },
            //       icon: Icon(
            //         Iconsax.filter,
            //         color: Color.fromARGB(255, 30, 117, 141),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meilleur offre",
                  style: GoogleFonts.barlow(
                      fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen()));
                    },
                    child: Text(
                      "voir tous",
                      style: GoogleFonts.lato(
                          fontSize: 15,
                          color: Color.fromARGB(255, 30, 117, 141),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            ProductOverview(),
          ]),
        ),
      ),
    );
  }
}

class MyserchDelegate extends SearchDelegate {
  DBHelper? dbHelper = DBHelper();
  List<Map<String, dynamic>> x = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        });
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    print('hello');
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> x = ["hello", "olla"];

    return ListView.builder(
        itemCount: x.length,
        itemBuilder: (context, index) {
          final suggestion = x[index];
          return ListTile(
            title: Text(suggestion.toString()),
            onTap: () {
              query = suggestion.toString();
            },
          );
        });
  }
}
