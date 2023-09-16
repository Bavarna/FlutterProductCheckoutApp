import 'package:flutter/material.dart';
import 'package:pizza_checkout_app/models/user_type.dart';

class UserTypeSelector extends StatelessWidget {
  final UserType selectedUserType;
  final void Function(UserType?) onSelect;
  final Key? key; // Add a named key parameter

  UserTypeSelector({
    required this.selectedUserType,
    required this.onSelect,
    this.key, // Initialize the key parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Select User Type:'),
        DropdownButton<UserType>(
          value: selectedUserType,
          onChanged: onSelect,
          items: UserType.values.map((userType) {
            return DropdownMenuItem<UserType>(
              value: userType,
              child: Text(userType.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}
