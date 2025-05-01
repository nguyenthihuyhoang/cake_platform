import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _address = '';
  String _paymentMethod = 'COD';

  void _handleCheckout() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Process order
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đặt hàng thành công!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final selectedItems = cart.items.where((item) => item.isSelected).toList();

    if (selectedItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Thanh toán'),
          backgroundColor: Color(0xFF70AE98),
          centerTitle: true,
        ),
        body: Center(child: Text('Không có sản phẩm nào được chọn')),
      );
    }

    final subtotal = selectedItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    final shipping = 30000.0;
    final total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
        backgroundColor: Color(0xFF70AE98),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // 1. Thông tin giao hàng
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin giao hàng',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Họ tên người nhận',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Vui lòng nhập họ tên'
                          : null,
                      onSaved: (value) => _name = value ?? '',
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Vui lòng nhập số điện thoại'
                          : null,
                      onSaved: (value) => _phone = value ?? '',
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Địa chỉ giao hàng',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Vui lòng nhập địa chỉ'
                          : null,
                      onSaved: (value) => _address = value ?? '',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // 2. Đơn hàng của bạn
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đơn hàng của bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...selectedItems.map(
                      (item) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.product.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.product.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${item.product.price.toStringAsFixed(0)}đ x ${item.quantity}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${(item.product.price * item.quantity).toStringAsFixed(0)}đ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tạm tính'),
                        Text('${subtotal.toStringAsFixed(0)}đ'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phí vận chuyển'),
                        Text('${shipping.toStringAsFixed(0)}đ'),
                      ],
                    ),
                    Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng cộng',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${total.toStringAsFixed(0)}đ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF70AE98),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // 3. Phương thức thanh toán
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phương thức thanh toán',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.money),
                          SizedBox(width: 6),
                          Text('Thanh toán khi nhận hàng'),
                        ],
                      ),
                      value: 'COD',
                      groupValue: _paymentMethod,
                      onChanged: (value) =>
                          setState(() => _paymentMethod = value!),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(width: 6),
                          Text('Chuyển khoản ngân hàng'),
                        ],
                      ),
                      value: 'BANK',
                      groupValue: _paymentMethod,
                      onChanged: (value) =>
                          setState(() => _paymentMethod = value!),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Nút đặt hàng
            ElevatedButton(
              onPressed: _handleCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF70AE98),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Đặt hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
