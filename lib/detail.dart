import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/cart_entity.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/product_data.dart';
import 'package:layout/providers.dart';
import 'package:layout/utils.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final ProductData data;

  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  var log = Logger();
  var utils = Utils();
  int qty = 1;
  int numItems = 0;

  void increment() {
    setState(() {
      qty++;
    });
  }

  void decrement() {
    setState(() {
      if (qty > 0) {
        qty--;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var myData = widget.data;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('PRODUCT DETAIL'),
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.purple,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: Badge(
                badgeContent: Text('${context.watch<CartItemCounter>().itemCount}'),
                badgeColor: Colors.yellow,
                child: IconButton(
                  onPressed: () {
                    utils.navigateToShoppingCart(context);
                  },
                  icon: Image.asset('images/cart7.png'),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                myData.imageUrl,
                width: 400,
                height: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                myData.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Price: \$${myData.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16, right: 16),
              child: Text(
                'Category: ${myData.category}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16, right: 16),
              child: Text(
                myData.description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      decrement();
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.remove),
                    heroTag: 'subtractButton',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$qty',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: () {
                      increment();
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.add),
                    heroTag: 'plusButton',
                  )
                ],
              ),
            ),
            Padding(
              //**********Add To Cart Button***********
              padding: const EdgeInsets.only(
                  top: 24.0, left: 16, right: 16, bottom: 24),
              child: MaterialButton(
                onPressed: () async {
                  //utils.makeASnackBar('Added to Cart', context);
                  context.read<CartItemCounter>().plusOne();
                  final database = await $FloorAppDatabase
                      .databaseBuilder('my_database.db')
                      .build();
                  final cartDao = database.cartDao;
                  var addedItem = CartEntity(
                      title: myData.title,
                      description: myData.description,
                      category: myData.category,
                      imageUrl: myData.imageUrl,
                      price: myData.price,
                      quantity: qty);

                  cartDao.insertCartItem(addedItem);
                  Navigator.of(context).pop();
                  utils.makeASnackBar('Item added to Cart', context);
                },
                color: Colors.purple,
                textColor: Colors.white,
                child: const Text('Add to cart'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            )
          ],
        ));
  }
}
