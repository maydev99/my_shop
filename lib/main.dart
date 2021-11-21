import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/product_grid2.dart';
import 'package:layout/utils.dart';
import 'package:badges/badges.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final dao = database.cartDao;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var log = Logger();
  var utils = Utils();

  //int numItems = utils.getItemCount() as Int;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.initState();
  }



  /*Future<void> getData() async {
    final database =
    await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
  }*/


  @override
  Widget build(BuildContext context) {
   // var numItems = utils.getItemCount();
    //log.i('Items: $numItems');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppe Michael '),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.purple,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
        actions: <Widget> [
          IconButton(onPressed: () {
            utils.navigateToShoppingCart(context);
          }, icon: Image.asset('images/cart7.png'),
          )
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              const Text(
                'shoppe michael',
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WhiteDream'),
                  textAlign: TextAlign.center,
              ),

              const Text(
                'Select a Category',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    print('Electronics');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid2(myCategory: 'electronics',)));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Electronics'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    print('Jewelery');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid2(myCategory: 'jewelery',)));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Jewelery'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    print('Men\'s Clothing');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid2(myCategory: "men's clothing",)));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Men\'s Clothing'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    print('Women\'s Clothing');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid2(myCategory: "women's clothing",)));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Women\'s Clothing'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
