import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/features/cart/model/cart_model.dart';
import 'package:nicestore/models/products_model.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  /// Add product to cart
  void addToCart(Products product, int quantity) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      // Not in cart, add new
      state = [...state, CartItem(product: product, quantity: quantity)];
    } else {
      // Already in cart, increase quantity
      final updated = [...state];
      updated[index].quantity += quantity;
      state = updated;
    }
  }

  /// Remove product from cart
  void removeFromCart(Products product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  /// Update quantity of a product
  void updateQuantity(Products product, int quantity) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      final updated = [...state];
      updated[index].quantity = quantity;
      state = updated;
    }
  }

  /// Total items in cart
  int totalItems() => state.fold(0, (sum, item) => sum + item.quantity);

  /// Total price
  double totalPrice() =>
      state.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
