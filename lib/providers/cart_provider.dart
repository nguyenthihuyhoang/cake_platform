// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  bool isSelected;

  CartItem({required this.product, this.quantity = 1, this.isSelected = true});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product, {int quantity = 1}) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        // Có thể xác nhận xóa hoặc chỉ giảm về 1
        _items[index].quantity = 1;
      }
      notifyListeners();
    }
  }

  void toggleSelect(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].isSelected = !_items[index].isSelected;
      notifyListeners();
    }
  }

  double get totalSelectedPrice => _items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.product.price * item.quantity);
}
