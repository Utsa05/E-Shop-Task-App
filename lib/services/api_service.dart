import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/product.dart';

class ApiService {
  final baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts({String? query, String? category}) async {
    final url = query != null
        ? '$baseUrl/search?q=$query'
        : category != null
            ? '$baseUrl/category/$category'
            : '$baseUrl?limit=100';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Convert the 'products' list from the response body into a list of Product objects
      return List<Product>.from(
          data['products'].map((e) => Product.fromJson(e)));
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse('$baseUrl/categories'));

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
