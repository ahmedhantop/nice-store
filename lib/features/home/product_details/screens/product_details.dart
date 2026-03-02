import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/custom_button.dart';
import 'package:nicestore/features/cart/notifier/state_notifier.dart';
import 'package:nicestore/models/products_model.dart';
import 'package:nicestore/features/home/product_details/screens/star_rating.dart';

class ProductDescriptionScreen extends ConsumerStatefulWidget {
  final Products product;

  const ProductDescriptionScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState
    extends ConsumerState<ProductDescriptionScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================== > Product Image ===========================
            Center(
              child: Image.network(
                widget.product.image,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.category,
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            /// Title
            Text(
              widget.product.title,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// Category
            Text(
              "${widget.product.description}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            /// Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to favorites ❤️")),
                    );
                  },
                  icon: Icon(Icons.favorite_border, color: Colors.redAccent),
                ),
              ],
            ),

            /// ================= > Rating Stars ========================
            Row(
              children: [
                StarRating(rating: widget.product.rating.rate, size: 20),
                const SizedBox(width: 8),
                Text(
                  "${widget.product.rating.rate} (${widget.product.rating.count} reviews)",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            /// =================>   Add to Cart Button ========================
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: CustomButton(
          size: ButtonSize.large,
          text: "Add to Cart",
          onPressed: () {
            ref.read(cartProvider.notifier).addToCart(widget.product, quantity);
          },

          backgroundColor: AppColors.secondary,
          fullWidth: true,
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
