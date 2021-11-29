import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/ui/shopping_cart.dart';
import 'package:logger/logger.dart';

import '../cart_db/cart_entity.dart';
import '../cart_db/database.dart';

var count = 0;

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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
  }

  getCartCount() async {
    var log = Logger();
    List<String> myCartList = [];
    final database =
        await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    Stream<List<CartEntity>> myData = myDao.getAllCartItems();
    myData.listen((value) {
      myCartList.clear();
      for (var item in value) {
        myCartList.add(item.title);
      }
      log.e(myCartList.length);
      count = myCartList.length;
    });

    return count;
  }
}
