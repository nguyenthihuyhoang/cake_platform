import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String address = '';
  String paymentMethod = 'COD';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final selectedItems = cart.items.where((item) => item.isSelected).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
        backgroundColor: Color(0xFF70AE98),
        centerTitle: true,
      ),
      body:
          selectedItems.isEmpty
              ? Center(child: Text('Không có sản phẩm nào được chọn!'))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Text(
                        'Sản phẩm:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...selectedItems.map(
                        (item) => ListTile(
                          title: Text(item.product.name),
                          trailing: Text('x${item.quantity}'),
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Họ tên người nhận',
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Nhập họ tên'
                                    : null,
                        onSaved: (value) => name = value ?? '',
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Số điện thoại'),
                        keyboardType: TextInputType.phone,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Nhập số điện thoại'
                                    : null,
                        onSaved: (value) => phone = value ?? '',
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Địa chỉ giao hàng',
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Nhập địa chỉ'
                                    : null,
                        onSaved: (value) => address = value ?? '',
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Phương thức thanh toán:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField<String>(
                        value: paymentMethod,
                        items: [
                          DropdownMenuItem(
                            value: 'COD',
                            child: Text('Thanh toán khi nhận hàng'),
                          ),
                          DropdownMenuItem(
                            value: 'Bank',
                            child: Text('Chuyển khoản ngân hàng'),
                          ),
                          DropdownMenuItem(
                            value: 'Momo',
                            child: Text('Ví Momo'),
                          ),
                        ],
                        onChanged:
                            (value) =>
                                setState(() => paymentMethod = value ?? 'COD'),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF0A35E),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // TODO: Lưu đơn hàng vào database hoặc mock list
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Đặt hàng thành công!')),
                            );
                            Navigator.pop(context); // Quay lại màn hình trước
                          }
                        },
                        child: Text(
                          'Xác nhận đặt hàng',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
