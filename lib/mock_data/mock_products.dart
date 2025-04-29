import '../models/product.dart';

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Bánh kem dâu',
    imageUrl: 'assets/images/cake1.jpg',
    description: 'Bánh kem dâu tươi thơm ngon.',
    price: 120000,
    rating: 4.8,
  reviewCount: 25,
  ),
  Product(
    id: '2',
    name: 'Bánh mì Pháp',
    imageUrl: 'assets/images/cake2.jpg',
    description: 'Bánh mì Pháp giòn tan.',
    price: 25000,
    rating: 2.8,
  reviewCount: 15,
  ),
  // Thêm các sản phẩm khác...
];
