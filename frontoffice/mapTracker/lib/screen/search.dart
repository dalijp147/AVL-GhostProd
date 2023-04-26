import 'package:flutter/material.dart';
import 'package:map/Service/api_service.dart';
import 'package:map/screen/homepage.dart';

import '../Models/product.dart';
import 'detailScreen.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for a product',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
      ),
      body: FutureBuilder<List<Product>?>(
        future: APIService.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            final filteredProducts = products
                .where((product) => product.name!.contains(_searchQuery))
                .toList();
            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(model: products[index]),
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
                    subtitle: Text(product.description!),
                    trailing: Text(product.price.toString()),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error loading products');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
