import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scrolling/loading.dart';
import 'package:infinite_scrolling/no_products.dart';
import 'package:infinite_scrolling/providers/product_provider.dart';
import 'package:provider/provider.dart';

import 'product_grid_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  // At the beginning, we fetch the first 10 products
  int page = 1;

  // You can change this value to fetch more or less products per page (10, 15, 5, etc)
  final int perPage = 10;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    setState(() {
      _isFirstLoadRunning = true;
    });

    Map<String, dynamic> fetchData =
        await productProvider.fetchProducts(page: "$page", perPage: "$perPage");
    log("Status: ${fetchData["status"]}");

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenever the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      page += 1; // Increase _page by 1

      Map<String, dynamic> fetchData = await productProvider.fetchProducts(
          page: "$page", perPage: "$perPage");
      log("Status: ${fetchData["status"]}");

      if (fetchData["status"]) {
        if (fetchData["list"].length < 10) {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Infinite Product List"),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  ProductGridView(controller: _controller),

                  // when the _loadMore function is running
                  CustomLoader(showLoader: _isLoadMoreRunning),

                  // When there is no next page
                  NoMoreProduct(show: !_hasNextPage),
                ],
              ),
            ),
    );
  }
}
