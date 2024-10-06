import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';
// Method to get products from json file
class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      return data.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
