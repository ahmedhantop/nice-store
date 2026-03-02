import 'package:nicestore/models/products_model.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
