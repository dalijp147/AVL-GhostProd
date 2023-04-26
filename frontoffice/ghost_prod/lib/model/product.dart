import 'package:flutter/material.dart';

List<Product> productsFromJson(dynamic str) =>
    List<Product>.from((str).map((x) => Product.fromJson(x)));

class Product with ChangeNotifier {
  late String? name, description, id;
  late int? price, quantity;
  late bool? isFavourite;
  late dynamic? imageUrl;
  late dynamic? imageUrl2;
  Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageUrl,
    this.quantity,
    this.isFavourite,
    this.imageUrl2,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    price = json["price"];
    description = json["description"];
    quantity = json["quantity"];
    imageUrl = json["imageUrl"][0];
    imageUrl2 = json["imageUrl"];
    print(List<String>.from(json["imageUrl"].map((x) => x)));
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = this.id;
    _data["description"] = this.description;
    _data["imageUrl"] = this.imageUrl;
    _data["price"] = this.price;
    _data["name"] = this.name;
    _data["quantity"] = this.quantity;
    return _data;
  }
}
