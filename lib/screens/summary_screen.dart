import 'package:flutter/material.dart';
import 'package:pizza_checkout_app/core/checkout.dart';
import 'package:pizza_checkout_app/models/product_type.dart';
import 'package:pizza_checkout_app/models/user_type.dart';

class SummaryScreen extends StatelessWidget {
  final Checkout checkout = Checkout.instance;
  final UserType? selectedUserType;
  final double total;
  final VoidCallback onNewOrder;

  SummaryScreen({
    required this.selectedUserType,
    required this.total,
    required this.onNewOrder,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out entries where the pizza count is 0
    final pizzaEntries = checkout.items.entries.where((entry) => entry.value > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Card(
        elevation: 5, // Add elevation for a card effect
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'User Type: ${selectedUserType?.name}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: pizzaEntries.map((entry) {
                  final productName = entry.key.productName;
                  final productQuantity = entry.value;
                  return ListTile(
                    title: Text('$productName'),
                    trailing: Text('x$productQuantity'),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Total Price: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onNewOrder();
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
