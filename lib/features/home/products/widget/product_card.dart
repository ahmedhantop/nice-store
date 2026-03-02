import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/custom_button.dart';
import 'package:nicestore/features/cart/notifier/state_notifier.dart';
import 'package:nicestore/models/products_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
//

// class ProductDescriptionScreen extends ConsumerWidget {
//   final ProductModel product;

//   const ProductDescriptionScreen({super.key, required this.product});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // for example

//
class ProductCardWidget extends ConsumerWidget {
  final Products product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int quantity = 1;
    // log(Product.tvgLogo);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: CachedNetworkImage(
              width: 150,
              height: 120,
              fit: BoxFit.contain,
              imageUrl: product.image,

              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Skeleton.shade(
                    child: Icon(Icons.production_quantity_limits, size: 12),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 12),
          //   child: FittedBox(
          //     child: Text(
          //       product.category,
          //       style: TextStyle(
          //         fontSize: 10,
          //         color: AppColors.secondary,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 20,
              child: Text(
                product.title.substring(0, 15) + "...",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 20,
              child: Text(
                product.description.substring(0, 20) + "...",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    final rating = product.rating.rate;

                    if (index < rating.floor()) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      );
                    } else if (index < rating) {
                      return const Icon(
                        Icons.star_half,
                        color: Colors.amber,
                        size: 16,
                      );
                    } else {
                      return const Icon(
                        Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }
                  }),
                ),
                Text(
                  product.rating.rate.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "\$${product.price.toString()}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
              size: ButtonSize.small,
              text: "Add to Cart",
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product, quantity);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "$quantity x ${product.title} added to cart!",
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              //width: 150,
              height: 35,
              backgroundColor: AppColors.secondary,
              fullWidth: true,
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
