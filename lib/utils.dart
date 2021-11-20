import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/shopping_cart.dart';

class Utils {

  void makeASnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void navigateToShoppingCart(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ShoppingCartPage()));
  }
}