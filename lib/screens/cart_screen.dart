import 'package:flutter/material.dart';
import '../mock_data/mock_cart.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = mockCart.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        backgroundColor: Color(0xFF70AE98),
        centerTitle: true,
      ),
      body:
          mockCart.isEmpty
              ? Center(child: Text('Giỏ hàng trống'))
              : ListView.builder(
                itemCount: mockCart.length,
                itemBuilder: (context, index) {
                  final cartItem = mockCart[index];
                  return ListTile(
                    leading: Image.asset(
                      cartItem.product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cartItem.product.name),
                    subtitle: Text(
                      '${cartItem.product.price.toStringAsFixed(0)} VNĐ',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (cartItem.quantity > 1) {
                                cartItem.quantity--;
                              }
                            });
                          },
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              cartItem.quantity++;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              mockCart.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      bottomNavigationBar:
          mockCart.isEmpty
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
                  onPressed: () {
                    // TODO: Chuyển sang màn hình Checkout
                  },
                  child: Text(
                    'Thanh toán (${total.toStringAsFixed(0)} VNĐ)',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
    );
  }
}
