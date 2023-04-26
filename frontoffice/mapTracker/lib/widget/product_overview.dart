import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../provider/product_provider.dart';
import '../screen/detail.dart';
import '../screen/detailScreen.dart';
import '../Service/api_service.dart';
import '../widget/product_item.dart';

import '../Models/product.dart';

class ProductOverview extends StatelessWidget {
  List<Product> products = List<Product>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
   

    return loadProduct();
  }

  // ignore: avoid_types_as_parameter_names
  Widget productList(products) {
    return Container(
      height: 700,
      width: 500,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) => Detail(model: products[i]),
                  ),
                );
              },
              child: ProductItem(model: products[i]));
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.2,
            mainAxisSpacing: 12.2,
            mainAxisExtent: 250),
      ),
    );
  }

  Widget loadProduct() {
    return FutureBuilder(
        future: APIService.getProduct(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>?> model) {
          if (model.hasData) {
            return productList(model.data);
          } else if (model.hasError) {
            return Text('${model.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
