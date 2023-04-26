import 'package:flutter/material.dart';
import 'package:map/Service/api_service.dart';

import '../Models/product.dart';
import 'filter.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await APIService.getProduct();
    if (products != null) {
      setState(() {
        _products = products;
      });
    }
  }

  void _filterProducts(BuildContext context) async {
    final filteredProducts = await Navigator.of(context).push<List<Product>>(
      MaterialPageRoute(
        builder: (context) => FilterScreen(products: _products),
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
        title: Text('Product List'),
        actions: [
          IconButton(
            onPressed: () => _filterProducts(context),
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.name!),
            subtitle: Text(product.price.toString()),
          );
        },
      ),
    );
  }
}
