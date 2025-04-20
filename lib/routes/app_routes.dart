import 'package:get/get.dart';
import '../bindings/product_binding.dart';
import '../views/pages/product_details_page/product_details_page.dart';
import '../views/pages/products_page/products_page.dart';

class AppRoutes {
  static const initial = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => ProductsPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: '/details',
      page: () => ProductDetailPage(),
    ),
  ];
}
