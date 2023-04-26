import 'package:flutter/material.dart';
import 'package:map/Models/dbfavorite.dart';
import 'package:map/Models/favorite.dart';
import '../provider/favorite_provider.dart';
import '../provider/product_provider.dart';
import '../screen/detailScreen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../Models/cart.dart';
import '../Models/dbhelper.dart';
import '../Models/product.dart';
import '../provider/cart_provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, this.model}) : super(key: key);
  final Product? model;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<Favoriteprovider>(context);

    DBHelper? dbHelper = DBHelper();
    DBFavorite? dbfavorite = DBFavorite();
    final cart = Provider.of<CartProvider>(context, listen: false);
    void saveData(Product model) {
      dbHelper
          .insert(
        Cart(
          id: model.price!.toInt(),
          productId: model.id,
          productName: model.name,
          initialPrice: model.discount!,
          productPrice: model.price,
          quantity: ValueNotifier(1),
          unitTag: model.priceAfterDiscount!.toString(),
          imageUrl: model.imageUrl,
        ),
      )
          .then((value) {
        cart.addTotalPrice(widget.model!.price!.toDouble());
        cart.addCounter();
        print(value.unitTag);
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    void saveFavorite(Product model) {
      dbfavorite
          .insert(
        Favorite(
            id: model.price!.toInt(),
            name: model.name,
            price: model.price,
            imageUrl: model.imageUrl),
      )
          .then((value) {
        print('Product Added to Favorite');
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
                    onPressed: () {
                      saveFavorite(widget.model!);
                    },
                    icon: Icon(fav.isExist(widget.model!.price!)
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Colors.red,
                  ),
                  (widget.model!.discount != 0)
                      ? Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              '${widget.model?.discount} %',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 230, 230, 230)),
                            ),
                          ),
                        )
                      : Text(''),
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
                  widget.model!.imageUrl,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (widget.model!.discount != 0)
                        ? Text('${widget.model?.priceAfterDiscount} DT',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                        : Text(
                            '${widget.model?.price} DT',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
