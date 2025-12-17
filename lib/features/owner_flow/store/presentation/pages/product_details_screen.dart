import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/features/owner_flow/store/domain/entities/product_entity.dart';
import 'package:rifq/features/owner_flow/store/presentation/cubit/store_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.image, height: 260),
            const SizedBox(height: 16),
            Text(product.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 8),
            Text('${product.price} SAR',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<StoreCubit>().addToCart(product);
                  context.push(Routes.cart);
                },
                child: const Text('Add to cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
