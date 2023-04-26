import 'package:flutter/material.dart';
import 'package:map/Service/api_service.dart';

import '../Models/product.dart';
import 'detailScreen.dart';
import 'filter.dart';

class HPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HPage> {
  List<Product>? _products;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    final products = await APIService.getProduct();
    setState(() {
      _products = products;
    });
  }

  void _showFilterScreen() async {
    final filteredProducts = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FilterScreen(products: _products ?? []),
      ),
    );
    if (filteredProducts != null) {
      setState(() {
        _products = filteredProducts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        title: Text(
          "filter les produits",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterScreen,
          ),
        ],
      ),
      body: _products != null
          ? ListView.builder(
              itemCount: _products!.length,
              itemBuilder: (context, index) {
                final product = _products![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(model: _products![index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(
                      product.imageUrl!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    title: Text(product.name!),
                    subtitle: Text('${product.price} \$'),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
