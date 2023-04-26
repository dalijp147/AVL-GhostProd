import 'package:ghost_prod/model/product.dart';
import 'package:ghost_prod/repository/repository.dart';

class ProsuctController {
  final Repository _repository;
  ProsuctController(this._repository);
  Future<List<Product>> fetchProduct() async {
    return _repository.getProduct();
  }
}
