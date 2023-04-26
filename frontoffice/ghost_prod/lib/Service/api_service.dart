import 'dart:convert';

import 'package:ghost_prod/controller/config.dart';
import 'package:ghost_prod/model/cart.dart';
import 'package:ghost_prod/widget/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart_service.dart';
import '../model/product.dart';

class APIService {
  static var client = http.Client();
  static Future<List<Product>?> getProduct() async {
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.productURL);
    var response = await client.get(url, headers: requestheader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  // ignore: avoid_types_as_parameter_names
  static Future<bool?> savecart(d, int total) async {
    print(d);
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.cartUrl);
    var response = await client.post(url,
        headers: requestheader,
        body: jsonEncode({
          "client_id": "63b0aab1a97e288c85b1d91b",
          "produits": d,
          "total": total.toInt()
        }));

    if (response.statusCode == 200) {
      var data = jsonEncode(response.body);
      print(data);
      return true;
    } else {
      return null;
    }
  }
}
