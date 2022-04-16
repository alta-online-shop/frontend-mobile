part of './product_service.dart';

class Product {
  int? id;
  String name;
  String? description;
  int price;
  List<Category>? categories;

  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var product = Product(
      id: json['ID'],
      name: json['Name'],
      description: json['Description'],
      price: json['Price'],
    );
    if (json['Categories'] != null) {
      product.categories = json['Categories']
          .map<Category>((v) => Category.fromJson(v))
          .toList();
    }

    return product;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ID'] = id;
    data['Name'] = name;
    data['Description'] = description;
    data['Price'] = price;
    if (categories != null) {
      data['Categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
