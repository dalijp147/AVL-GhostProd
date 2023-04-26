import 'package:flutter/material.dart';

class Favorite {
  final int id;

  final String? name;

  final int? price;

  final String? imageUrl;

  var cart;

  Favorite({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  Favorite.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        name = data['productName'],
        price = data['productPrice'],
        imageUrl = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': name,
      'productPrice': price,
      'image': imageUrl,
    };
  }
}
