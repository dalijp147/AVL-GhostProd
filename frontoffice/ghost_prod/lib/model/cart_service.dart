import 'cart.dart';

class CardApi {
  late String? id;
  late List<Cart?> products;
  late String? total;

  CardApi({
    required this.id,
    required this.products,
    required this.total,
  });
  CardApi.fromJson(Map<String, dynamic> json) {
    id = json["client_id"];
    products = json["produits"];
    total = json["price"];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["client_id"] = this.id;
    _data["produits"] = this.products;
    _data["total"] = this.total;

    return _data;
  }
}
