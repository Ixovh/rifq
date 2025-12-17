import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/store/domain/entities/product_entity.dart';
import 'package:rifq/features/owner_flow/store/presentation/cubit/store_cubit.dart';
import 'package:rifq/features/owner_flow/store/presentation/cubit/store_state.dart';
import 'package:rifq/features/owner_flow/store/presentation/widgets/product_card_store_widget.dart';

final List<ProductEntity> products = [
  ProductEntity(
    id: '1',
    name: 'Josera Mini Deluxe',
    image: 'assets/images/josera.png',
    price: 340,
    category: 'Food',
    description: 'High quality dog food',
  ),
  ProductEntity(
    id: '2',
    name: 'Pedigree Adult',
    image: 'assets/images/pedigree.png',
    price: 150,
    category: 'Food',
    description: 'Balanced nutrition',
  ),
  ProductEntity(
    id: '5',
    name: 'Royal Canin',
    image: 'assets/images/royal.png',
    price: 110,
    category: 'Food',
    description: 'High quality dog food',
  ),
  ProductEntity(
    id: '6',
    name: 'BlackHawk Puppy lamb',
    image: 'assets/images/blackhawk.png',
    price: 90,
    category: 'Food',
    description: 'Balanced nutrition',
  ),
  ProductEntity(
    id: '3',
    name: 'Dog Toy',
    image: 'assets/images/toy.png',
    price: 50,
    category: 'Toys',
    description: 'Fun toy',
  ),
  ProductEntity(
    id: '4',
    name: 'Cat Toy',
    image: 'assets/images/cat_toy.png',
    price: 40,
    category: 'Toys',
    description: 'Cat fun',
  ),
];

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreCubit(),
      child: Scaffold(
        backgroundColor: context.background,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Pet Store',
            style: context.body1.copyWith(color: context.primary50),
          ),
          backgroundColor: context.background,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: context.primary50),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: context.primary50),
              onPressed: () {
                context.push(Routes.cart);
              },
            ),
          ],
        ),
        ////////////////////////////////////
        body: Column(
          children: [
             BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              StoreCategoryItem(
                                title: 'Food',
                                image: 'assets/images/fod.png',
                                isSelected: state.selectedCategory == 'Food',
                                onTap: () => context
                                    .read<StoreCubit>()
                                    .changeCategory('Food'),
                              ),
                              const SizedBox(width: 16),
                              StoreCategoryItem(
                                title: 'Toys',
                                image: 'assets/images/toys.png',
                                isSelected: state.selectedCategory == 'Toys',
                                onTap: () => context
                                    .read<StoreCubit>()
                                    .changeCategory('Toys'),
                              ),
                              const SizedBox(width: 16),
                              StoreCategoryItem(
                                title: 'Accessories',
                                image: 'assets/images/accessories.png',
                                isSelected:
                                    state.selectedCategory == 'Accessories',
                                onTap: () => context
                                    .read<StoreCubit>()
                                    .changeCategory('Accessories'),
                              ),
                              const SizedBox(width: 16),
                              StoreCategoryItem(
                                title: 'Clothes',
                                image: 'assets/images/clothes.png',
                                isSelected: state.selectedCategory == 'Clothes',
                                onTap: () => context
                                    .read<StoreCubit>()
                                    .changeCategory('Clothes'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {}, // فلتر لاحقاً
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  final filteredProducts = products
                      .where((p) => p.category == state.selectedCategory)
                      .toList();

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (_, i) {
                      final product = filteredProducts[i];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          context.push(Routes.productDetails, extra: product);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),

        /////////////////////////////////////

      ),
    );
  }
}

class StoreCategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const StoreCategoryItem({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? context.primary50 : Colors.transparent,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(image),
              backgroundColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: context.body3.copyWith(
              color: isSelected ? context.primary50 : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
