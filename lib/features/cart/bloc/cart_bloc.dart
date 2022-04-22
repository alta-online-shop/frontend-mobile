import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/cart/bloc/cart_event.dart';
import 'package:frontend_mobile/features/cart/bloc/cart_state.dart';
import 'package:frontend_mobile/services/cart/cart_service.dart';
import 'package:frontend_mobile/services/product/product_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(carts: [])) {
    on<AddIntoCart>((event, emit) async {
      final isExists = state.carts
          .map<int>((e) => e.product.id)
          .toList()
          .contains(event.product.id);
      List<Cart> carts = [
        ...state.carts,
      ];
      if (isExists) {
        carts = carts.map<Cart>((e) {
          if (e.product.id == event.product.id) {
            e.qty++;
          }
          return e;
        }).toList();
      } else {
        carts.add(Cart(id: event.product.id, product: event.product, qty: 1));
      }

      emit(CartState(carts: carts));
    });
  }

  @override
  void onTransition(Transition<CartEvent, CartState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
