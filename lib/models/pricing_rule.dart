import 'package:pizza_checkout_app/models/product_type.dart';
import 'package:pizza_checkout_app/models/rule.dart';
import 'package:pizza_checkout_app/models/user_type.dart';

class PricingRule {
  final UserType userType;
  final Rule rule;
  final ProductType product;
  final double? discountPrice;

  PricingRule({
    required this.userType,
    required this.rule,
    required this.product,
    this.discountPrice,
  });
}
