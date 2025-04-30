import 'package:cake_platform/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        backgroundColor: Color(0xFF70AE98),
        centerTitle: true,
      ),
      body:
          cart.items.isEmpty
              ? Center(child: Text('Giỏ hàng trống'))
              : ListView.separated(
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    ProductDetailScreen(product: item.product),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.product.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      item.product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.product.price.toStringAsFixed(0)} VNĐ'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed:
                                  () => cart.decreaseQuantity(item.product),
                            ),
                            Text(
                              '${item.quantity}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed:
                                  () => cart.increaseQuantity(item.product),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Expanded(
                          child: Checkbox(
                            value: item.isSelected,
                            onChanged: (_) => cart.toggleSelect(item.product),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => cart.removeFromCart(item.product),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ProductDetailScreen(product: item.product),
                        ),
                      );
                    },
                  );
                },
              ),
      bottomNavigationBar:
          cart.items.isEmpty
              ? null
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF0A35E),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed:
                      cart.items.any((item) => item.isSelected)
                          ? () {
                            // TODO: Chuyển sang màn hình Checkout với các sản phẩm đã chọn
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutScreen(),
                              ),
                            );
                          }
                          : null,
                  child: Text(
                    'Thanh toán (${cart.totalSelectedPrice.toStringAsFixed(0)} VNĐ)',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
    );
  }
}
