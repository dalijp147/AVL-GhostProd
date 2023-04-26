import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../Models/product.dart';

class FilterScreen extends StatefulWidget {
  final List<Product> products;

  FilterScreen({required this.products});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _minPrice = 0;
  double _maxPrice = 100;

  void _applyFilters() {
    final filteredProducts = widget.products.where((product) {
      final price = product.price;
      return price! >= _minPrice && price <= _maxPrice;
    }).toList();
    Navigator.of(context).pop(filteredProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        title: Text(
          "Filtrer les produits",
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'prix',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),

            // Expanded(
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       labelText: 'Min Price',
            //       border: OutlineInputBorder(),
            //     ),
            //     initialValue: _minPrice.toString(),
            //     onChanged: (value) {
            //       setState(() {
            //         _minPrice = double.tryParse(value) ?? 0;
            //       });
            //     },
            //   ),
            // ),
            // SizedBox(width: 16.0),
            // Expanded(
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       labelText: 'Max Price',
            //       border: OutlineInputBorder(),
            //     ),
            //     initialValue: _maxPrice.toString(),
            //     onChanged: (value) {
            //       setState(() {
            //         _maxPrice = double.tryParse(value) ?? 1000;
            //       });
            //     },
            //   ),
            // ),

            RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              min: 0,
              max: 100,
              labels: RangeLabels(
                '\DT ${_minPrice.toStringAsFixed(0)} ',
                '\DT${_maxPrice.toStringAsFixed(0)}',
              ),
              onChanged: (values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
              activeColor: Color.fromARGB(255, 39, 152, 183),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_minPrice.toStringAsFixed(0)} '),
                Text('${_maxPrice.toStringAsFixed(0)}'),
              ],
            ),

            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _applyFilters,
              child: Text('Apply Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 39, 152, 183),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
