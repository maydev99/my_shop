import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/cart_entity.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/utils.dart';
import 'package:logger/logger.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  var log = Logger();
  var utils = Utils();
  List<CartEntity> myCartList = [];

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
      for (var item in value) {
        myCartList.add(CartEntity(
            title: item.title,
            description: item.description,
            category: item.category,
            imageUrl: item.imageUrl,
            price: item.price,
            quantity: item.quantity));
      }

      setState(() {

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
        actions: [
          IconButton(onPressed: () {
            deleteAll();
            utils.makeASnackBar('All items cleared from cart', context);
          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: List.generate(myCartList.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: _myCard(myCartList, index),
          );
        }),
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
                    deleteItemFromCart(myList[index]);
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
