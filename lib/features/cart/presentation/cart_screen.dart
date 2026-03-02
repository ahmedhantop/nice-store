import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/appbar.dart';
import 'package:nicestore/core/widgets/custom_button.dart';
import 'package:nicestore/core/widgets/empty_widget.dart';
import 'package:nicestore/core/widgets/main_app_bar.dart';
import 'package:nicestore/features/cart/notifier/state_notifier.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final totalPrice = cartNotifier.totalPrice();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: MainAppbar(title: "My Cart", showBackButton: false),
        ),
      ),
      backgroundColor: AppColors.background,
      // appBar: AppBar(title: const Text("My Cart")),
      body: cartItems.isEmpty
          ? EmptyWidget(
              icon: Icons.shopping_cart_outlined,
              message: "Your cart is empty",
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// ============== ? Cart Items List ========================
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];

                          return Card(
                            elevation: 2,
                            color: AppColors.grey.withOpacity(0.3),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  /// Product Image
                                  Image.network(
                                    item.product.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.contain,
                                  ),

                                  const SizedBox(width: 12),

                                  /// ============= > Product Info ========================
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "\$${item.product.price}",
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// ========== > Quantity Controls ===================
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            cartNotifier.updateQuantity(
                                              item.product,
                                              item.quantity - 1,
                                            );
                                          } else {
                                            cartNotifier.removeFromCart(
                                              item.product,
                                            );
                                          }
                                        },
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          cartNotifier.updateQuantity(
                                            item.product,
                                            item.quantity + 1,
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  /// Remove Button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      cartNotifier.removeFromCart(item.product);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// 💰 Total Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              size: ButtonSize.large,
                              backgroundColor: AppColors.secondary,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Checkout coming soon 🚀"),
                                  ),
                                );
                              },
                              text: "Checkout",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
