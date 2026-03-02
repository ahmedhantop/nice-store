import 'package:flutter/material.dart';
import 'package:nicestore/models/products_model.dart';

class ProductsItem extends StatelessWidget {
  final Products product;

  const ProductsItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigate to the products details screen
          // Navigator.pushNamed(context, products.routeName);
          //         Navigator.of(context).push(
          // MaterialPageRoute(builder: (context) => LocationSearchScreen()));
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),

          height: 120,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // products Image
              Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    // TODO: Replace with actual asset image
                    image: AssetImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
                // Placeholder icon - replace with actual image
                // child: const Icon(Icons.directions_car, size: 40, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              // products Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
