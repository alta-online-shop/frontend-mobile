import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mobile/features/home/bloc/home_event.dart';
import 'package:frontend_mobile/features/home/bloc/home_state.dart';
import 'package:frontend_mobile/services/product/product_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(products: [])) {
    on<GetAllProducts>((event, emit) async {
      final products = await ProductService.getAllProducts();
      emit(HomeState(products: products));
    });
  }

  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
