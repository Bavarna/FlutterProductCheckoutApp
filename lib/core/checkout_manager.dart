import 'package:pizza_checkout_app/models/product_type.dart';
import 'package:pizza_checkout_app/models/rule.dart';
import 'package:pizza_checkout_app/models/user_type.dart';

import '../models/pricing_rule.dart';
import '../models/product.dart';

class CheckoutManager {
  final List<Product> products = [
    Product(productType: ProductType.small, price: 11.99),
    Product(productType: ProductType.medium, price: 15.99),
    Product(productType: ProductType.large, price: 21.99),
  ];


  final Map<UserType, List<PricingRule>> pricingRules = {
    UserType.microsoft: [
      PricingRule(userType: UserType.microsoft, rule: Rule.threeForTwo, product: ProductType.small),
      // Add other rules for Microsoft user type
    ],
    UserType.amazon: [
      PricingRule(userType: UserType.amazon, rule: Rule.discount, product:  ProductType.large, discountPrice: 19.99),
      // Add other rules for Amazon user type
    ],
    UserType.facebook: [
      PricingRule(userType: UserType.facebook, rule:Rule.fiveForFour, product: ProductType.medium),
      // Add other rules for Facebook user type
    ],
    // Add other user types and their rules
  };

  double applyPricingRule(Rule rule, int itemCount, double productPrice, double? discountPrice) {
    switch (rule) {
      case Rule.threeForTwo:
        return applyXForYRule(itemCount, 3, 2, productPrice);
      case  Rule.discount:
        return itemCount * (discountPrice ?? productPrice);
      case Rule.fiveForFour:
        return applyXForYRule(itemCount, 5, 4, productPrice);
      default:
        return itemCount * productPrice;
    }
  }

  double applyXForYRule(int itemCount, int x, int y, double productPrice) {
    return (itemCount ~/ x * y + itemCount % x) * productPrice;
  }



  double calculateTotal(UserType userType, Map<ProductType, int> selectedPizzas) {
    double total = 0;

    for (final productName in selectedPizzas.keys) {
      final product = products.firstWhere((p) => p.productType == productName);
      final itemCount = selectedPizzas[productName]!;
      final userRules = pricingRules[userType] ?? [];

      final pricingRule = userRules.firstWhere(
            (rule) => rule.product == productName,
        orElse: () => PricingRule(userType: UserType.defaultUser, rule: Rule.none, product: ProductType.small),
      );

      if (pricingRule.rule != null) {
        total += applyPricingRule(
          pricingRule.rule,
          itemCount,
          product.price,
          pricingRule.discountPrice,
        );
      } else {
        total += itemCount * product.price;
      }
    }

    return total;
  }
}
