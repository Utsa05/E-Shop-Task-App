import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //proudct image
            product.images.length > 1
                ? ProductSliderWidget(product: product)
                : ProductImage(product: product),

            //product description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(product.category, style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text("${product.price}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Text(product.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(product.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: product.images[0],
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}

class ProductSliderWidget extends StatelessWidget {
  const ProductSliderWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: product.images.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        enlargeCenterPage: true,
        autoPlay: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.9,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
