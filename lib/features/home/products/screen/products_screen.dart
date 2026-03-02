import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/providers/products_provider.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/appbar.dart';
import 'package:nicestore/core/widgets/error_widget.dart';
import 'package:nicestore/core/widgets/loading_widget.dart';
import 'package:nicestore/core/widgets/search_widget.dart';
import 'package:nicestore/features/home/products/widget/product_card.dart';
import 'package:nicestore/models/products_model.dart';
import 'package:nicestore/features/home/product_details/screens/product_details.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  TextEditingController searchController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(productServiceProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productServiceProvider);

    /// 🔹 Loading
    if (state.isLoading) {
      return const Center(child: LoadingWidget());
    }

    /// 🔹 Error
    if (state.error != null) {
      return Center(
        child: ErrorDisplayWidget(
          message: state.error!,
          onRetry: () {
            ref.read(productServiceProvider.notifier).loadItems();
          },
        ),
      );
    }

    /// 🔹 Group products locally (UI level only)
    final Map<String, List<Products>> grouped = {};

    for (var product in state.items) {
      grouped.putIfAbsent(product.category, () => []);
      grouped[product.category]!.add(product);
    }

    /// 🔹 Display grouped UI
    ///
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        bottom: SearchWidget(searchController: searchController),
        showSearch: true,
        //  actions: [],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: grouped.entries.map((entry) {
          final category = entry.key;
          final products = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Category Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 5,
                  children: List.generate(products.length, (index) {
                    return SizedBox(
                      width: 150,
                      height: 280,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDescriptionScreen(
                              product: products[index],
                            ),
                          ),
                        ),
                        child: ProductCardWidget(product: products[index]),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
