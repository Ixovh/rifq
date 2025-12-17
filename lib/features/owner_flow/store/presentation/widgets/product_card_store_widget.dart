import 'package:flutter/material.dart';
import 'package:rifq/features/owner_flow/store/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(child: Image.asset(product.image)),
            const SizedBox(height: 8),
            Text(product.name, maxLines: 1),
            const SizedBox(height: 4),
            Text('${product.price} SAR',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
