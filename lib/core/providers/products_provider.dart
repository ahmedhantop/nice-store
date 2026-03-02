import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/constants/api_endpoints.dart';
import 'package:nicestore/core/network/enhanced_network_handler.dart';
import 'package:nicestore/core/providers/lists_viewmodel.dart';
import 'package:nicestore/models/products_model.dart';
import 'dart:core';

final productServiceProvider =
    StateNotifierProvider<ListsViewModel<Products>, ListsState<Products>>(
      (ref) => ListsViewModel<Products>(
        ref.read(enhancedNetworkHandlerProvider),
        Products.fromJson,
        ApiEndpoints.products,
      ),
    );

final groupedProductsProvider = Provider<Map<String, List<Products>>>((ref) {
  final state = ref.watch(productServiceProvider);

  if (state.items.isEmpty) return {};

  final Map<String, List<Products>> map = {};

  for (var product in state.items) {
    map.putIfAbsent(product.category, () => []);
    map[product.category]!.add(product);
  }

  return map;
});
