import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../services/api_service.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => ProductController(apiService: Get.find()));
  }
}
