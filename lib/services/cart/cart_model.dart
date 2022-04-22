part of './cart_service.dart';

class Cart {
  final int id;
  int qty = 0;
  final Product product;

  Cart({
    required this.id,
    required this.product,
    this.qty = 1,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      qty: json['qty'],
      product: Product.fromJson(
        json['product'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['qty'] = qty;
    data['product'] = product.toJson();
    return data;
  }
}
