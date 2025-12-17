import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/store/domain/entities/product_entity.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit()
      : super(
          StoreState(
            selectedCategory: 'Food',
            cart: [],
          ),
        );

  void changeCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void addToCart(ProductEntity product) {
    final updatedCart = List<ProductEntity>.from(state.cart)..add(product);
    emit(state.copyWith(cart: updatedCart));
  }

  void removeFromCart(ProductEntity product) {
    final updatedCart = List<ProductEntity>.from(state.cart)
      ..remove(product);
    emit(state.copyWith(cart: updatedCart));
  }

  void clearCart() {
    emit(state.copyWith(cart: []));
  }
}
