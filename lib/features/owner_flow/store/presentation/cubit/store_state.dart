import 'package:equatable/equatable.dart';
import 'package:rifq/features/owner_flow/store/domain/entities/product_entity.dart';

class StoreState extends Equatable {
  final String selectedCategory;
  final List<ProductEntity> cart;

  const StoreState({
    required this.selectedCategory,
    required this.cart,
  });

  StoreState copyWith({
    String? selectedCategory,
    List<ProductEntity>? cart,
  }) {
    return StoreState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, cart];
}
