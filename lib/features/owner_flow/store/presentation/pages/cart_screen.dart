import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/store/presentation/cubit/store_cubit.dart';
import 'package:rifq/features/owner_flow/store/presentation/cubit/store_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (_, i) {
                    final product = state.cart[i];
                    return ListTile(
                      leading: Image.asset(product.image, width: 40),
                      title: Text(product.name),
                      subtitle: Text('${product.price} SAR'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<StoreCubit>().removeFromCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('Your payment was successful'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<StoreCubit>().clearCart();
                                context.pop(); // dialog
                                context.pop(); // cart
                              },
                              child: const Text('Go Back'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Pay'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
