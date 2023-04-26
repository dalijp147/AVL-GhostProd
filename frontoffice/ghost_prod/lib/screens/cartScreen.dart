import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ghost_prod/Service/api_service.dart';
import 'package:ghost_prod/provider/product_provider.dart';
import 'package:ghost_prod/screens/addressScreen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:sqflite/sqflite.dart';
import '../model/cart.dart';
import '../model/dbhelper.dart';
import '../model/product.dart';
import '../provider/cart_provider.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  List<Map<String, dynamic>> x = [];
  List<Map<String, dynamic>> t = [];
  void getDataAndPrint() async {
    await dbHelper!.getData().then((value) {
      print(value);
      List<Map<String, dynamic>> newValue = value
          .map((e) => ({
                '_id': e['productId'],
                'quantity': e['productPrice'],
                'total': e['productPrice'] * e['quantity']
              }))
          .toList();
      x.clear();
      x.addAll(newValue);
    });
  }

  void getDataAndtotal() async {
    await dbHelper!.getData().then((value) {
      print(value);
      List<Map<String, dynamic>> newValue = value
          .map((e) => ({'total': e['productPrice'] * e['quantity']}))
          .toList();
      t.clear();
      t.addAll(newValue);
    });
  }

  final ValueNotifier<int?> totalPrice = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    getDataAndPrint();
    getDataAndtotal();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    List<Product> products = List<Product>.empty(growable: true);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 34, 40, 49),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: 40,
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back_ios_new_sharp),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 39, 152, 183),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: 40,
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      icon: Icon(Iconsax.shop),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.centerLeft,
                height: 110,
                width: 200,
                child: Text("My Cart",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 26, 26),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cart.cart.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  color: Color.fromARGB(255, 26, 26, 26),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '${cart.cart[index].productName!}\n',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                              ),
                                              RichText(
                                                maxLines: 1,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '${cart.cart[index].productPrice!} DT',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ValueListenableBuilder<int>(
                                            valueListenable:
                                                cart.cart[index].quantity!,
                                            builder: (context, val, child) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: PlusMinusButtons(
                                                  addQuantity: () {
                                                    cart.addQuantity(
                                                        cart.cart[index].id);
                                                    dbHelper!
                                                        .updateQuantity(Cart(
                                                      id: index,
                                                      productId:
                                                          index.toString(),
                                                      productName: cart
                                                          .cart[index]
                                                          .productName,
                                                      initialPrice: cart
                                                          .cart[index]
                                                          .initialPrice,
                                                      productPrice: cart
                                                          .cart[index]
                                                          .productPrice,
                                                      quantity: ValueNotifier(
                                                          cart.cart[index]
                                                              .quantity!.value),
                                                      unitTag: cart
                                                          .cart[index].unitTag,
                                                    ))
                                                        .then((value) {
                                                      setState(() {
                                                        cart.addTotalPrice(
                                                            double.parse(cart
                                                                .cart[index]
                                                                .productPrice
                                                                .toString()));
                                                      });
                                                    });
                                                  },
                                                  deleteQuantity: () {
                                                    cart.deleteQuantity(
                                                        cart.cart[index].id!);
                                                    cart.removeTotalPrice(
                                                        double.parse(cart
                                                            .cart[index]
                                                            .productPrice
                                                            .toString()));
                                                  },
                                                  text: val.toString(),
                                                ),
                                              );
                                            }),
                                        IconButton(
                                            onPressed: () {
                                              dbHelper!.deleteCartItem(
                                                  cart.cart[index].id);
                                              cart.removeItem(
                                                  cart.cart[index].id);
                                              cart.removeCounter();
                                            },
                                            icon: Icon(
                                              Iconsax.trash,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                for (var element in value.cart) {
                  totalPrice.value =
                      (element.productPrice! * element.quantity!.value) +
                          (totalPrice.value ?? 0);
                }
                return Column(
                  children: [
                    ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          return ReusableWidget(
                              title: 'Total',
                              value: r'DT' + (val?.toStringAsFixed(2) ?? '0'));
                        }),
                  ],
                );
              },
            ),
            Divider(
              height: 1,
            ),
            Container(
              height: 100,
              color: Color.fromARGB(255, 26, 26, 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(326, 54),
                      primary: Color.fromARGB(255, 39, 152, 183),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      // showModalBottomSheet(
                      //   context: context,
                      //   backgroundColor: Colors.white,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadiusDirectional.only(
                      //       topEnd: Radius.circular(25),
                      //       topStart: Radius.circular(25),
                      //     ),
                      //   ),
                      //   builder: (BuildContext context) {
                      //     return AddressScreen();
                      //   });

                      getDataAndPrint();
                      getDataAndtotal();
                      APIService.savecart(x, totalPrice as int);
                    },
                    child: Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            color: Colors.white,
            onPressed: deleteQuantity,
            icon: const Icon(
              Icons.remove,
            )),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
            color: Colors.white,
            onPressed: addQuantity,
            icon: const Icon(
              Icons.add,
            )),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color.fromARGB(255, 26, 26, 26),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              value.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
