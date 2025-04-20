import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/product_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/shimmer_loader.dart';

class ProductsPage extends StatelessWidget {
  final controller = Get.find<ProductController>();

  ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("eShop Task")),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAll();
        },
        child: Column(
          children: [
            //search bar
            Searchbar(controller: controller),
            //cartegories
            Categories(controller: controller),
            //products
            ProductGrid(controller: controller)
          ],
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.controller,
  });

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) return const ShimmerLoader();
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: controller.products.length,
          itemBuilder: (_, i) => ProductCard(product: controller.products[i]),
        );
      }),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.controller,
  });

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: controller.categories.map((cat) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  checkmarkColor: controller.selectedCategory.value == cat.name
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  label: Text(
                    cat.name,
                    style: TextStyle(
                        color: controller.selectedCategory.value == cat.name
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).primaryColor),
                  ),
                  selected: controller.selectedCategory.value == cat.name,
                  onSelected: (_) => controller.filterByCategory(cat.name),
                ),
              );
            }).toList(),
          ),
        ));
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
    required this.controller,
  });

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(
        placeholder: "Search products...",
        onChanged: controller.searchProducts,
      ),
    );
  }
}
