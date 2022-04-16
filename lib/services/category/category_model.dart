part of './category_service.dart';

class Category {
  int? id;
  String name;
  String? description;

  Category({this.id, required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'],
      name: json['Name'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ID'] = id;
    data['Name'] = name;
    data['Description'] = description;
    return data;
  }
}
