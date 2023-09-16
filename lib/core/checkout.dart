// checkout.dart
import 'package:pizza_checkout_app/models/product_type.dart';
import 'package:pizza_checkout_app/models/user_type.dart';
import '../models/product.dart';
import 'checkout_manager.dart';

class Checkout {
  final CheckoutManager checkoutManager = CheckoutManager();
  final Map<ProductType, int> items = {};

  void incrementItemCount(ProductType itemName) {
    if (items.containsKey(itemName)) {
      items[itemName] = items[itemName]! + 1;
    } else {
      items[itemName] = 1;
    }
  }

  void decrementItemCount(ProductType itemName) {
    if (items.containsKey(itemName) && items[itemName]! > 0) {
      items[itemName] = items[itemName]! - 1;
    }
  }

  double total(UserType userType) {
    return checkoutManager.calculateTotal(userType, items);
  }

  void clear() {
    items.clear();
  }

  int getItemCount(ProductType itemName) {
    return items[itemName] ?? 0;
  }

  List<Product> getProducts() {
    return checkoutManager.products; // Retrieve products from CheckoutManager
  }
}
