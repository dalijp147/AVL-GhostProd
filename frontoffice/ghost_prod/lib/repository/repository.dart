import 'package:ghost_prod/model/product.dart';

abstract class Repository {
  Future<List<Product>> getProduct();
  Future<String> patchComplete(Product todo);
}
