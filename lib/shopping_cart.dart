import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);


  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  //Variables and functions


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
    );
  }
}