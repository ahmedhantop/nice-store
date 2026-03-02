import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/providers/products_provider.dart';
import 'package:nicestore/features/home/products/widget/product_card.dart';
import 'package:nicestore/features/home/product_details/screens/product_details.dart';

class CategoryProductsScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  ConsumerState<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState
    extends ConsumerState<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();

    /// Ensure products are loaded
    Future.microtask(() {
      ref.read(productServiceProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productServiceProvider);

    return Expanded(
      child: Builder(
        builder: (context) {
          /// 🔹 Loading
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// 🔹 Error
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          /// 🔹 Filter Locally
          final filteredProducts = state.items
              .where((p) => p.category == widget.category)
              .toList();

          if (filteredProducts.isEmpty) {
            return const Center(
              child: Text("No products found in this category"),
            );
          }

          /// 🔥 Success Grid
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDescriptionScreen(
                      product: filteredProducts[index],
                    ),
                  ),
                ),
                child: ProductCardWidget(product: filteredProducts[index]),
              );
            },
          );
        },
      ),
      //  ),
    );
  }
}
