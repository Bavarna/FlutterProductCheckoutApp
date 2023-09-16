import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_checkout_app/models/product_type.dart';
import 'package:pizza_checkout_app/models/user_type.dart';
import 'package:pizza_checkout_app/core/checkout_manager.dart';
import 'package:pizza_checkout_app/core/checkout.dart';

void main() {
  test('Test CalculateTotal in CheckoutManager', () {

    print("Case 1: \nCustomer: default \nItems:\n Small Pizza x1\n Medium Pizza x1\n Large Pizza x1\nOutput: Total \$49.97");
    final checkoutManager = CheckoutManager();
    final selectedPizzas = {
       ProductType.small: 1,
      ProductType.medium: 1,
      ProductType.large:1,
    };

    // Test with UserType.default
    final total = checkoutManager.calculateTotal(
      UserType.defaultUser,
      selectedPizzas,
    );
    expect(total, 49.97);

    // Test with UserType.microsoft

    print("\nCase 2: \nCustomer: Microsoft \nItems:\n Small Pizza x3\n Large Pizza x1\nOutput: Total \$45.97");

    final selectedPizzasM = {
      ProductType.small: 3,
      ProductType.large:1,
    };
    final totalMicrosoft = checkoutManager.calculateTotal(
      UserType.microsoft,
      selectedPizzasM,
    );
    expect(totalMicrosoft, 45.97);

    // Test with UserType.amazon


    print("\nCase 3: \nCustomer: Amazon \nItems:\n Medium Pizza x3\n Large Pizza x1\nOutput: Total \$67.96");

    final selectedPizzasAmazon = {
      ProductType.medium: 3,
      ProductType.large:1,
    };
    final totalAmazon = checkoutManager.calculateTotal(
      UserType.amazon,
      selectedPizzasAmazon,
    );
    expect(totalAmazon, 67.96);

    // Add more test cases as needed for other user types and scenarios
  });

  test('Test Checkout Class', () {
    final checkout = Checkout();

    // Test incrementItemCount and getItemCount
    checkout.incrementItemCount(ProductType.small);
    expect(checkout.getItemCount(ProductType.small), 1);

    // Test decrementItemCount
    checkout.decrementItemCount(ProductType.small);
    expect(checkout.getItemCount(ProductType.small), 0);

    // Test total
    checkout.incrementItemCount(ProductType.medium);
    final total = checkout.total(UserType.amazon);
    expect(total, 15.99);

    // Test getProducts
    final products = checkout.getProducts();
    expect(products.length, 3); // Assuming there are three products in CheckoutManager's products list

    // Test clear
    checkout.clear();
    expect(checkout.getItemCount(ProductType.small), 0);
  });
}
