import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghost_prod/model/size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:rate/rate.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/cart.dart';
import '../model/dbhelper.dart';
import '../model/product.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import 'calender2.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, this.model}) : super(key: key);
  final Product? model;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<Products>(context).items;
    final providers = Provider.of<Products>(context);
    DBHelper? dbHelper = DBHelper();
    final cart = Provider.of<CartProvider>(context, listen: false);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: widget.model!.name,
          initialPrice: widget.model!.price,
          productPrice: widget.model!.price,
          quantity: ValueNotifier(1),
          unitTag: widget.model!.name,
        ),
      )
          .then((value) {
        cart.addTotalPrice(widget.model!.price!.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
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
                    Text(
                      'Product Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          icon: Icon(Iconsax.shopping_bag),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 250,
                            width: 500,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CarouselSlider.builder(
                                        itemCount:
                                            widget.model!.imageUrl2!.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          final urlmage =
                                              widget.model!.imageUrl2![index];
                                          return buildImage(urlmage, index);
                                        },
                                        options: CarouselOptions(
                                            height: 200,
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: false)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.55,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: Colors.white),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getResponsiveItemSize(
                                            width: size.width, value: 30),
                                        right: getResponsiveItemSize(
                                            width: size.width, value: 30),
                                        top: size.height * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.model!.name!,
                                            style:
                                                GoogleFonts.barlowSemiCondensed(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                          '${widget.model!.price.toString()} DT',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 39, 152, 183),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          SizedBox(height: 20.0),
                                          DefaultTabController(
                                              length: 2, // length of tabs
                                              initialIndex: 0,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    Container(
                                                      child: TabBar(
                                                        labelColor:
                                                            Color.fromARGB(
                                                                255, 0, 0, 0),
                                                        unselectedLabelColor:
                                                            Colors.grey[400],
                                                        tabs: [
                                                          Tab(
                                                            text:
                                                                'Disponnbilité',
                                                          ),
                                                          Tab(text: 'Detaille'),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          400, //height of TabBarView
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.5))),
                                                      child: TabBarView(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Center(
                                                                child:
                                                                    CAlenderSc()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                        'Descriprion :'),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      widget
                                                                          .model!
                                                                          .description
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey[600]),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ])),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getResponsiveItemSize(width: size.width, value: 20)),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height * 0.07,
            child: MaterialButton(
                color: Color.fromARGB(255, 39, 152, 183),
                onPressed: () {
                  saveData(widget.model!.price!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add to Card",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
