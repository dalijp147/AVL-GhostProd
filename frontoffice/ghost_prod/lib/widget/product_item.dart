import 'package:flutter/material.dart';
import 'package:ghost_prod/provider/product_provider.dart';
import 'package:ghost_prod/screens/detailScreen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../controller/product_controller.dart';
import '../model/cart.dart';
import '../model/dbhelper.dart';
import '../model/product.dart';
import '../provider/cart_provider.dart';
import '../repository/productrepository.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, this.model}) : super(key: key);
  final Product? model;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    DBHelper? dbHelper = DBHelper();
    List<Product> products = List<Product>.empty(growable: true);

    var productController = ProsuctController(ProductRepositroy());
    final cart = Provider.of<CartProvider>(context, listen: false);
    void saveData(Product model) {
      dbHelper
          .insert(
        Cart(
          id: model.price!.toInt(),
          productId: model.id,
          productName: model.name,
          initialPrice: model.price,
          productPrice: model.price,
          quantity: ValueNotifier(1),
          unitTag: model.name,
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

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        saveData(widget.model!);
                      });
                    },
                    icon: Icon(Iconsax.shopping_bag),
                    color: Color.fromARGB(255, 39, 152, 183),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  'https://www.usaoncanvas.com/images/low_res_image.jpg',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.model?.price} DT',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(widget.model!.name!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
