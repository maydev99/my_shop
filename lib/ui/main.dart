import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/cart_db/cart_entity.dart';
import 'package:layout/cart_db/database.dart';
import 'package:layout/ui/product_grid.dart';
import 'package:layout/utils/providers.dart';
import 'package:layout/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:need_resume/need_resume.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final dao = database.cartDao;
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CartItemCounter())],
    child: const MyApp(),
  ));
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

class _MyHomePageState extends ResumableState<MyHomePage> {
  var log = Logger();
  var utils = Utils();

  int numberOfItems = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    getData();
    super.initState();
  }

  List<CartEntity> myCartList = [];
  int count = 0;

  Future<void> getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    var myDao = database.cartDao;
    Stream<List<CartEntity>> myData = myDao.getAllCartItems();
    myData.listen((value) {
      myCartList.clear();
      for (var item in value) {
        count++;
      }
      context.read<CartItemCounter>().setItemCount(count);

    });
  }

  @override
  Widget build(BuildContext context) {
    // var numItems = utils.getItemCount();
    //log.i('Items: $numItems');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppe Michael '),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid(
                                  myCategory: 'electronics',
                                )));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Electronics'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid(
                                  myCategory: 'jewelery',
                                )));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Jewelery'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid(
                                  myCategory: "men's clothing",
                                )));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Men\'s Clothing'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  minWidth: 200,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductGrid(
                                  myCategory: "women's clothing",
                                )));
                  },
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: const Text('Women\'s Clothing'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
