import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/providers/products_provider.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/empty_widget.dart';
import 'package:nicestore/core/widgets/loading_widget.dart';
import 'package:nicestore/core/widgets/main_app_bar.dart';
import 'package:nicestore/features/category/category_card.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  String? selectedCategory;

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
      return const Scaffold(body: Center(child: LoadingWidget()));
    }

    /// 🔹 Error
    if (state.error != null) {
      return Scaffold(body: Center(child: ErrorWidget(state.error!)));
    }

    /// 🔹 No Data
    if (state.items.isEmpty) {
      return const Scaffold(
        body: Center(child: EmptyWidget(message: "No products found")),
      );
    }

    /// 🔥 Extract Unique Categories
    final categories = state.items
        .map((product) => product.category)
        .toSet()
        .toList();

    /// 🔥 Filtered Products
    final filteredProducts = selectedCategory == null
        ? []
        : state.items.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: MainAppbar(title: "All categories", showBackButton: false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ✅ Dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text("Select Category"),
              items: categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 20),

            /// ============>  Show products of selected category =============
            if (selectedCategory != null)
              Expanded(
                child: CategoryProductsScreen(
                  category: filteredProducts[0].category,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
