import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/models/products_data.dart';
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
  List<CustomProduct> customProductList = [];

  @override
  void initState() {
    makeNetworkCall(widget.myCategory);
    super.initState();
  }

  void makeNetworkCall(String myCategory) async {
    var response = await Dio()
        .get('https://fakestoreapi.com/products/category/$myCategory');

    if (response.statusCode == 200) {
      var productData = ProductsData.fromJson(response.data);

      customProductList.clear();
      List<ProductsData>? data = productData as List<ProductsData>?;
      for (var product in data!) {
        customProductList.add(CustomProduct(
            product.title.toString(),
            product.price.toString(),
            product.description.toString(),
            product.category.toString(),
            product.image.toString()));

       log.i(product.title);
      }


      log.i('Size: ${customProductList.length}');
    }
    /*setState(() {
      try {
        var rawData = ProductsData.fromJson(response);
        //var productTitle = rawData.title;
        log.i(productTitle);
        */ /*var rawData = Drink.fromJson(response.data);
        name = rawData.strDrink;
        imageUrl = rawData.strDrinkThumb.toString();
        instructions = rawData.strInstructions;
        logger.i(imageUrl);*/ /*

      } catch (e) {
        log.e(e);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    String myCat = widget.myCategory;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(myCat),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
    );
  }
}
