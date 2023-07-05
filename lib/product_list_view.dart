import 'package:flutter/material.dart';

import 'models/product_model.dart';
import 'product_list_item.dart';

class ProductListView extends StatelessWidget {
  final ScrollController controller;
  final List<Product> productList;
  const ProductListView(
      {super.key, required this.controller, required this.productList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: controller,
        itemCount: productList.length,
        padding: const EdgeInsets.all(8.0),
        separatorBuilder: (context, index) =>
        const SizedBox(height: 8.0),
        itemBuilder: (context, index) {
          return ProductListItem(product: productList[index]);
        },
      ),
    );
  }
}
