import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/detail.dart';
import 'package:layout/product_data.dart';
import 'package:layout/services/api_service.dart';
import 'package:layout/utils.dart';
import 'package:logger/logger.dart';

////https://fakestoreapi.com/docs

class ProductGrid2 extends StatefulWidget {
  final String myCategory;

  const ProductGrid2({Key? key, required this.myCategory}) : super(key: key);

  @override
  _ProductGrid2State createState() => _ProductGrid2State();
}

class _ProductGrid2State extends State<ProductGrid2> {
  var log = Logger();
  var utils = Utils();


  @override
  Widget build(BuildContext context) {
    String myCat = widget.myCategory;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          myCat.toUpperCase(),
        ),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              utils.navigateToShoppingCart(context);
            },
            icon: Image.asset('images/cart7.png'),
          )
        ],
      ),
      body: FutureBuilder(
          future: ApiService().getProductsByCategory(myCat),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2 / 4,
                shrinkWrap: true,
                children: List.generate(snapshot.data.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: GestureDetector(
                      onTap: () {
                        var myProductData = ProductData(
                            title: snapshot.data[index]['title'],
                            description: snapshot.data[index]['description'],
                            category: snapshot.data[index]['category'],
                            imageUrl: snapshot.data[index]['image'],
                            price: double.parse(
                                snapshot.data[index]['price'].toString()));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(
                                      data: myProductData,
                                    )));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.fade,
                                  strutStyle: const StrutStyle(fontSize: 12.0),
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    text: snapshot.data[index]['title'],
                                  ),
                                ),
                              ),
                              Image.network(
                                snapshot.data[index]['image'],
                                width: 180,
                                height: 250,
                              ),
                              Text(
                                "\$${snapshot.data[index]['price']}",
                                style: const TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
