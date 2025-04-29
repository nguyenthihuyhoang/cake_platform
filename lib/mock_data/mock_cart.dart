import 'package:cake_platform/mock_data/mock_products.dart';

import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

List<CartItem> mockCart = [
  CartItem(product: mockProducts[0], quantity: 2),
  CartItem(product: mockProducts[1], quantity: 1),
];
