import 'package:equatable/equatable.dart';
import 'package:frontend_mobile/services/product/product_service.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddIntoCart extends CartEvent {
  final Product product;
  AddIntoCart({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}
