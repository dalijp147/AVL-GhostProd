import 'dart:convert';

import 'package:ghost_prod/model/product.dart';
import 'package:ghost_prod/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProductRepositroy implements Repository {
  String dataURl = 'http://192.168.1.23:5000';
  String url =
      Platform.isAndroid ? 'http://192.168.1.23:5000' : 'http://localhost:5000';

  @override
  Future<List<Product>> getProduct() async {
    List<Product> todoList = [];
    var url = Uri.parse('$dataURl/api/products');
    var response = await http.get(url);

    print(response.body);
    var bodys = json.decode(response.body);
    print(bodys);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    // for (var i = 0; i < body?.length; i++) {
    //   todoList.add(Product.fromJson(body?[i]));
    // }
    List<Product> posts = body.map((model) => Product.fromJson(model)).toList();
    print(posts);
    return bodys;
  }

  @override
  Future<String> patchComplete(Product todo) {
    // TODO: implement patchComplete
    throw UnimplementedError();
  }
}
