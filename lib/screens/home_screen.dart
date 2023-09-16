// home_screen.dart
import 'package:flutter/material.dart';
import 'package:pizza_checkout_app/core/checkout.dart';
import 'package:pizza_checkout_app/models/product.dart';
import 'package:pizza_checkout_app/models/user_type.dart';
import 'package:pizza_checkout_app/screens/summary_screen.dart';
import 'package:pizza_checkout_app/widgets/pizza_counter.dart';
import 'package:pizza_checkout_app/widgets/user_type_selector.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Checkout checkout = Checkout();

  UserType? selectedUserType = UserType.defaultUser;
  UserType? dropdownValue;

  void calculateTotalAndCheckout() {
    final total = checkout.total(selectedUserType ?? UserType.defaultUser);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          checkout: checkout,
          selectedUserType: selectedUserType,
          total: total,
          onNewOrder: () {
            setState(() {
              checkout.clear();
              selectedUserType = UserType.defaultUser;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTypeSelector(
              selectedUserType: selectedUserType ?? UserType.defaultUser,
              onSelect: (UserType? userType) {
                setState(() {
                  dropdownValue = userType;
                  selectedUserType = userType ?? UserType.defaultUser;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Select Pizza Quantity:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Column(
              children: checkout.getProducts().map((product) {
                return PizzaCounter(
                  productType: product.productType,
                  quantity: checkout.getItemCount(product.productType),
                  onIncrement: (_) {
                    checkout.incrementItemCount(product.productType);
                    setState(() {});
                  },
                  onDecrement: (_) {
                    checkout.decrementItemCount(product.productType);
                    setState(() {});
                  },
                  key: Key(product.productType.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateTotalAndCheckout,
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
