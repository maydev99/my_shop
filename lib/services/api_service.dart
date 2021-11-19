import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {

  var log = Logger();

  Future getProductsByCategory(String myCategory) async {
    final productByCategoryUrl = Uri.parse('https://fakestoreapi.com/products/category/$myCategory');
    final response = await http.get(productByCategoryUrl);
    log.i(response.statusCode);
    log.i(response.body);
    return json.decode(response.body);
  }
}