import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/cart_entity.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/product_data.dart';
import 'package:layout/shopping_cart.dart';
import 'package:layout/utils.dart';
import 'package:logger/logger.dart';

class Detail extends StatelessWidget {
  final ProductData data;

  const Detail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DetailPage(productData: data),
    );
  }
}

class DetailPage extends StatefulWidget {
  final ProductData productData;

  const DetailPage({Key? key, required this.productData}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var log = Logger();
  var utils = Utils();


  @override
  Widget build(BuildContext context) {
    var myData = widget.productData;
    return Scaffold(
        appBar: AppBar(
          title: const Text('PRODUCT DETAIL'),
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.purple,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          actions: <Widget> [
            IconButton(onPressed: () {
              utils.navigateToShoppingCart(context);
            }, icon: Image.asset('images/cart7.png'),
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

            Padding( //**********Add To Cart Button***********
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(onPressed: () async{
                //utils.makeASnackBar('Added to Cart', context);
                final database = await $FloorAppDatabase.databaseBuilder('my_database.db').build();
                final cartDao = database.cartDao;
                var addedItem = CartEntity(
                    title: myData.title,
                    description: myData.description,
                    category: myData.category,
                    imageUrl: myData.imageUrl,
                    price: myData.price,
                    quantity: 1);

                cartDao.insertCartItem(addedItem);
              },
              color: Colors.purple,
              textColor: Colors.white,
              child: const Text('Add to cart'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
            )
          ],
        ));
  }
}

