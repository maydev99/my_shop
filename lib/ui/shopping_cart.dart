import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/cart_entity.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/utils/providers.dart';
import 'package:layout/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  var log = Logger();
  var utils = Utils();
  List<CartEntity> myCartList = [];
  //late double total;
  double shipping = 5.99;
  double taxRate = 0.06;
  double tax = 0.0;
  double subtotal = 0.0;
  double totalTotal = 0.0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    Stream<List<CartEntity>> myData = myDao.getAllCartItems();
    myData.listen((value) {
      myCartList.clear();
      subtotal = 0;
      for (var item in value) {
        var itemTotal = item.price * item.quantity;
        subtotal = subtotal + itemTotal;
        myCartList.add(CartEntity(
            title: item.title,
            description: item.description,
            category: item.category,
            imageUrl: item.imageUrl,
            price: item.price,
            quantity: item.quantity));
      }

      setState(() {
        subtotal;
        tax = subtotal * taxRate;
        totalTotal = subtotal + tax + shipping;


      });

    });
  }

  Future<void> deleteItemFromCart(CartEntity cartEntity) async {
    final database =
    await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    myDao.deleteCartItem(cartEntity);
  }

  Future<void> deleteAll() async {
    final database =
    await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    myDao.deleteAllCartItems();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Your Cart'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          _cartSummaryCard(),
          Expanded(
            child: ListView(
              children: List.generate(myCartList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _myCard(myCartList, index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Card _cartSummaryCard() {
    return Card(
      color: Colors.white,
      elevation: 10,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            const Text('Shopping Cart Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            Text('Subtotal: \$${subtotal.toStringAsFixed(2)}',),
            Text('Tax: \$${tax.toStringAsFixed(2)}'),
            Text('Shipping: \$${shipping.toStringAsFixed(2)}'),
            Text('Total: \$${totalTotal.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),),
            MaterialButton(onPressed: () {
              utils.makeASnackBar('Thank you for Shopping', context);
              deleteAll();
              context.read<CartItemCounter>().setToZero();
            },
            child: const Text('Check Out'),
            color: Colors.purple,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            ),)
          ],

        ),
      ),
    );
  }

  Card _myCard(List<CartEntity> myList, int index) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                myList[index].title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Image.network(
              myList[index].imageUrl,
              width: 400,
              height: 200,
            ),
            Text('\$${myList[index].price}'),
            Text('Quantity: ${myList[index].quantity}'),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: MaterialButton(
                  onPressed: () async {
                    log.i('Tap');
                    /*context.re
                    deleteItemFromCart(myList[index]);*/
                    getData();
                  },
                  textColor: Colors.red,
                  child: const Text('Remove from Cart'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  void showEmptyDialog() {
    Stack(
      children: const [
        Card(
          color: Colors.purple,
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: Text('Your cart in empty',
            style: TextStyle(
              fontSize: 40
            ),)),
          ),
        )
      ],
    );
  }
}
