import 'package:equatable/equatable.dart';
import 'package:frontend_mobile/services/product/product_service.dart';

class HomeState extends Equatable {
  final List<Product> products;
  const HomeState({
    required this.products,
  });

  @override
  List<Object?> get props => [products];
}
