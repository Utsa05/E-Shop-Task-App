import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/details', arguments: product),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(product.thumbnail,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text("${product.price}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(product.rating.toString()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
