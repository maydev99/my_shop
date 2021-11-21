import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/shopping_cart.dart';

import 'cart_db/cart_entity.dart';
import 'cart_db/database.dart';

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

/*  Future<int> getItemCount() async {
    List<CartEntity> myCartList = [];
    final database =
        await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    Stream<List<CartEntity>> myData = myDao.getAllCartItems();
    myData.listen((value) {
      myCartList.clear();
      for (var item in value) {
        myCartList.add(item);
      }
    });
    int numItems = myCartList.length;

    return numItems;
  }

  Future<int> getCount() async {
    //database connection
    final db = await $FloorAppDatabase.databaseBuilder('my_databse.db').build();
    var myDao = db.cartDao;
    var myCount = myDao.getItemCount();

    return myCount;
  }*/
}
