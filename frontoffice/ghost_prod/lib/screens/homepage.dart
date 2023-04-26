// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghost_prod/model/product.dart';
import 'package:ghost_prod/screens/cartScreen.dart';
import 'package:ghost_prod/screens/detailScreen.dart';
import 'package:ghost_prod/screens/historyscreen.dart';
import 'package:ghost_prod/screens/productScreen.dart';
import 'package:ghost_prod/screens/sms.dart';
import 'package:ghost_prod/widget/product_overview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

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
             
            },
            icon: Icon(Iconsax.notification),
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
              children: [
                Text("Selectionner category",
                    style: GoogleFonts.barlow(
                        fontWeight: FontWeight.bold, fontSize: 23)),
                Spacer(
                  flex: 2,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text("Voir tous",
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Color.fromARGB(255, 30, 117, 141),
                            fontWeight: FontWeight.bold)))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentindex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: currentindex == index
                                  ? Color.fromARGB(255, 39, 152, 183)
                                  : Colors.white),
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              categories[index]["iconPath"],
                              height: 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${categories.elementAt(index)["name"]}")
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 20,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 300,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 30, 117, 141),
                      ),
                      labelText: 'Recherche',
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(25),
                            topStart: Radius.circular(25),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                              bottom: 30,
                              top: 8,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      iconSize: 37,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Iconsax.close_square5),
                                    ),
                                    Text(
                                      "Option de filtrage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                    SizedBox(
                                      width: 86,
                                      height: 37,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 30, 117, 141),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // <-- Radius
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text('fait')),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Brand",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid,
                                                width: 0.80),
                                          ),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            value: dropdownvalue,

                                            // Down Arrow Icon
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "prix",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid,
                                                width: 0.90),
                                          ),
                                          child: DropdownButton(
                                            value: dropdownvaluePrice,
                                            isExpanded: true,

                                            // Down Arrow Icon
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: price.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvaluePrice = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "taille",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid,
                                                width: 0.80),
                                          ),
                                          child: DropdownButton(
                                            value: dropdownvalueSize,
                                            isExpanded: true,
                                            // Down Arrow Icon
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: size.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalueSize = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Iconsax.filter,
                      color: Color.fromARGB(255, 30, 117, 141),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nouveau Pack",
                  style: GoogleFonts.barlow(
                      fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
            Container(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 170,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Color.fromARGB(255, 26, 26, 26)),
                      child: Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Column(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 30, 117, 141),
                              ),
                              child: Center(
                                child: Text(
                                  'new',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 230, 230, 230)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Canon",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Super Mega deal ",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: (() {}),
                            child: Text(
                              "buy now",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 26, 26, 26)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 255, 255),
                              // put the width and height you want
                            ),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 170,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Color.fromARGB(255, 26, 26, 26)),
                      child: Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Column(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 30, 117, 141),
                              ),
                              child: Center(
                                child: Text(
                                  'new',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 230, 230, 230)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sony",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Super Mega deal ",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: (() {}),
                            child: Text(
                              "buy now",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 255, 255),
                              // put the width and height you want
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
