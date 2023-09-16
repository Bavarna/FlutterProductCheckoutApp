import 'package:flutter/material.dart';
import 'package:pizza_checkout_app/models/product_type.dart';

class PizzaCounter extends StatelessWidget {
  final ProductType productType;
  final int quantity;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final Key? key;

  PizzaCounter({
    required this.productType,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            productType.productName,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => onDecrement(quantity),
              ),
              Text(quantity.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onIncrement(quantity),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

