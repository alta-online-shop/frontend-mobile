import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend_mobile/services/category/category_service.dart';

part './product_model.dart';

class ProductService {
  static Future<List<Product>> getAllProducts() async {
    final api = GetIt.I.get<Dio>();
    final response = await api.get('/products');
    final data = response.data['data'];
    return data?.map<Product>((d) => Product.fromJson(d)).toList();
  }
}
