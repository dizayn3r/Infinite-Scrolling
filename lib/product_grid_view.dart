import 'package:flutter/material.dart';
import 'package:infinite_scrolling/providers/product_provider.dart';
import 'package:provider/provider.dart';

import 'models/product_model.dart';
import 'product_grid_item.dart';

class ProductGridView extends StatelessWidget {
  final ScrollController controller;
  final List<Product>? productList;

  const ProductGridView(
      {super.key, required this.controller, this.productList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          List<Product> productList = productProvider.productList;
          return GridView.count(
            controller: controller,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.8,
            children: List.generate(productList.length,
                (index) => ProductGridItem(product: productList[index])),
          );
        }
      ),
    );
  }
}
