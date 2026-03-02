// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nicestore/core/localization/app_strings.dart';
// import 'package:nicestore/core/widgets/empty_widget.dart';
// import 'package:nicestore/core/widgets/error_widget.dart';
// import 'package:nicestore/core/widgets/loading_widget.dart';
// import 'package:nicestore/features/home/data/models/products_model.dart';
// import 'package:nicestore/features/lists_viewmodel.dart';

// class ProductDetailsScreen extends ConsumerStatefulWidget {
//   const ProductDetailsScreen({super.key});

//   @override
//   ConsumerState<ProductDetailsScreen> createState() =>
//       _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(productsViewModelProvider.notifier).loadItems();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categoriesState = ref.watch(productsViewModelProvider);

//     return Scaffold(
//       // appBar:PreferredSize(
//       //   preferredSize: const Size.fromHeight(60),
//       //   child: NormalAppBar(
//       //     title: "Categories",
//       //     isBackAction: false,
//       //   ),
//       // ),
//       body: _CategoriesStateHandler(
//         state: categoriesState,
//         onRetry: _handleRetry,
//         onRefresh: _handleRefresh,
//       ),
//     );
//   }

//   void _handleRetry() {
//     ref.read(productsViewModelProvider.notifier).loadItems();
//   }

//   Future<void> _handleRefresh() async {
//     await ref.read(productsViewModelProvider.notifier).loadItems();
//   }
// }

// class _CategoriesStateHandler extends StatelessWidget {
//   const _CategoriesStateHandler({
//     required this.state,
//     required this.onRetry,
//     required this.onRefresh,
//   });

//   final dynamic state;
//   final VoidCallback onRetry;
//   final Future<void> Function() onRefresh;

//   @override
//   Widget build(BuildContext context) {
//     if (state.isLoading) {
//       return const LoadingWidget();
//     }

//     if (state.error != null) {
//       return ErrorDisplayWidget(message: state.error, onRetry: onRetry);
//     }

//     if (state.items.isEmpty) {
//       return EmptyWidget(message: AppStrings.noData.tr(), icon: Icons.cabin);
//     }

//     return _CategoriesList(categories: state.items, onRefresh: onRefresh);
//   }
// }

// class _CategoriesList extends StatelessWidget {
//   const _CategoriesList({required this.categories, required this.onRefresh});

//   final List<Products> categories;
//   final Future<void> Function() onRefresh;

//   static const EdgeInsets _listPadding = EdgeInsets.all(16);

//   @override
//   Widget build(BuildContext context) => RefreshIndicator(
//     onRefresh: onRefresh,
//     child: ListView.builder(
//       padding: _listPadding,
//       itemCount: categories.length,
//       itemBuilder: (context, index) =>
//           CategoryItem(category: categories[index]),
//     ),
//   );
// }
