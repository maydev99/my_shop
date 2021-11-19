import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/product_data.dart';
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
      home: const DetailPage(),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var log = Logger();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCT DETAIL'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
    );
  }
}
