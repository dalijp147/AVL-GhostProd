import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map/Models/db.dart';
import 'package:map/provider/location_provider.dart';
import 'package:map/screen/extensions.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Models/event.dart';
import '../Service/api_service.dart';
import '../provider/product_provider.dart';
import '../screen/addressScreen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/cart.dart';
import '../Models/dbhelper.dart';
import '../Models/product.dart';
import '../provider/cart_provider.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';
import 'ClientMap.dart';
import 'paymentScreen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  DB? db = DB();
  List<Map<String, dynamic>> x = [];

  final _formkey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;
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

  void getname() async {
    await dbHelper!.getData().then((value) {
      print(value);
      List<Map<String, dynamic>> newValue = value
          .map((e) => ({
                '_id': e['productName'],
              }))
          .toList();
      x.clear();
      x.addAll(newValue);
    });
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
      String formattedDate = DateFormat.yMMMEd().format(toDate);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({
    required bool pickDate,
  }) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  List<Map<String, dynamic>> l = [];
  void getDataAndPrintlocation() async {
    await db!.getDatalocation().then((value) {
      List<Map<String, dynamic>> newValue = value
          .map((e) => ({
                'longitude': e['longitude'],
                'latitude': e['latitude'],
              }))
          .toList();

      l.clear();
      l.addAll(newValue);

      print(newValue);
    });
  }

  List<Map<String, dynamic>> selectedDates = [];

  @override
  void initState() {
    super.initState();

    fromDate = DateTime.now();
    toDate = DateTime.now().add(Duration(hours: 2));

    getDataAndPrint();
    getDataAndPrintlocation();
    context.read<CartProvider>().getData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<int?> totalPrice = ValueNotifier(null);
  int numero = 0;
  List<Map<String, dynamic>> z = [];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    List<Product> products = List<Product>.empty(growable: true);
    final location = Provider.of<LocationProvider>(context).cart;
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
                child: Text("Mon panier",
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
                        height: 10,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10.0),
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
                                        Image.network(
                                          cart.cart[index].imageUrl!,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.contain,
                                        ),
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
                                              (cart.cart[index].initialPrice !=
                                                      0)
                                                  ? Text(
                                                      '${cart.cart[index].unitTag} DT',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : Text(
                                                      '${cart.cart[index].productPrice} DT',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),

                                              // RichText(
                                              //   maxLines: 1,
                                              //   text: TextSpan(
                                              //       style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontSize: 16.0),
                                              //       children: [
                                              //         TextSpan(
                                              //             text:
                                              //                 '${cart.cart[index].productPrice!} DT',
                                              //             style: const TextStyle(
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .bold)),
                                              //       ]),
                                              // ),
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
                                                      id: cart.cart[index].id,
                                                      productId: cart
                                                          .cart[index]
                                                          .productId,
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
                                                      imageUrl: cart
                                                          .cart[index].imageUrl,
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
                                                        cart.cart[index].id);
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
                      showModalBottomSheet(
                          elevation: 500,
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
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 20,
                                  end: 20,
                                  bottom: 5,
                                  top: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Form(
                                      key: _formkey,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Adresse de livraison',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                39, 152, 183),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ClientMap()));
                                                      },
                                                      child:
                                                          Text('set location'),
                                                    )),
                                              ],
                                            ),
                                            Text(
                                                "Vouillez choisire la date du reservation du produit :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Expanded(
                                              child: Container(
                                                height: 500,
                                                child: Scrollbar(
                                                  showTrackOnHover: true,
                                                  isAlwaysShown: true,
                                                  child: ListView.builder(
                                                      itemCount:
                                                          cart.cart.length,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          height: 400,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  ' Nom du produit:      ${cart.cart[index].productName!}\n',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              buildHeader(
                                                                header: 'Du',
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          builedDropDownField(
                                                                        text: Utils.toDate(
                                                                            fromDate),
                                                                        onClicked:
                                                                            () =>
                                                                                pickFromDateTime(
                                                                          pickDate:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              buildHeader(
                                                                header: 'Aux',
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          builedDropDownField(
                                                                        text: Utils.toDate(
                                                                            toDate),
                                                                        onClicked:
                                                                            () =>
                                                                                pickToDateTime(
                                                                          pickDate:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          39,
                                                                          152,
                                                                          183),
                                                                ),
                                                                onPressed: () {
                                                                  if (z.length ==
                                                                      cart.cart
                                                                          .length) {
                                                                    z.clear();
                                                                  } else {
                                                                    z.add({
                                                                      'title': cart
                                                                          .cart[
                                                                              index]
                                                                          .productName!,
                                                                      'startdate':
                                                                          Utils.toDate(
                                                                              fromDate),
                                                                      'enddate':
                                                                          Utils.toDate(
                                                                              toDate),
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                    'Ajouter'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _controller,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Entrer votre numero de telephone',
                                              ),
                                              onSaved: (value) =>
                                                  numero = int.parse(value!),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            getDataAndPrint();
                                            getDataAndPrintlocation();
                                            _formkey.currentState!.save();
                                            int? currentCounterValue =
                                                totalPrice.value;
                                            print(numero);
                                            print(l);
                                            print(z);
                                            print(currentCounterValue);
                                            APIService.savecart(x, l, z, numero,
                                                currentCounterValue);
                                          },
                                          child: Text(
                                            'Payée à la livraison',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 39, 152, 183),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: Size(137, 56),
                                            side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 39, 152, 183),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .only(
                                                    topEnd: Radius.circular(25),
                                                    topStart:
                                                        Radius.circular(25),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (BuildContext cc) {
                                                  return PaymentScreen();
                                                });
                                          },
                                          child: Text(
                                            'Payée par ' ' carte',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 39, 152, 183),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: Size(137, 56),
                                            side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 39, 152, 183),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });

                      // getDataAndPrint();
                      // getDataAndtotal();
                      // APIService.savecart(x, totalPrice as int);
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

Widget builedDropDownField({
  required String text,
  required VoidCallback onClicked,
}) =>
    ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
Widget buildHeader({required String header, required Widget child}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(header), child],
    );
