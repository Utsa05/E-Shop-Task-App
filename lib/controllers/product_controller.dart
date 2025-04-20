import 'package:eshop_task/models/category.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService apiService;
  ProductController({required this.apiService});

  var isLoading = true.obs;
  var products = <Product>[].obs;
  var categories = <Category>[].obs;
  var selectedCategory = ''.obs;
  var query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    try {
      isLoading(true);
      final prods = await apiService.fetchProducts();
      _fetchCategory();
      selectedCategory('');
      query('');
      products.assignAll(prods);
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchProducts(String q) async {
    query(q);
    selectedCategory("");
    isLoading(true);

    products.assignAll(await apiService.fetchProducts(query: q));
    isLoading(false);
  }

  Future<void> filterByCategory(String categoryName) async {
    selectedCategory(categoryName);
    isLoading(true);
    products.assignAll(await apiService.fetchProducts(category: categoryName));
    isLoading(false);
  }

  Future<void> _fetchCategory() async {
    categories.assignAll(await apiService.fetchCategories());
  }
}
