import 'product_type.dart';

class Product {
  final ProductType productType;
  final double price; // Use double for price

  Product({required this.productType, required this.price});
}
