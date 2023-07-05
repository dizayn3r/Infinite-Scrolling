import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {

  List<Product> _productList = [];
  List<Product> get productList => _productList;

  setProductList(List<Product> list){
    _productList.addAll(list);
    notifyListeners();
  }

  /// We will fetch data from this Rest Api
  final _baseUrl =
      "https://ecomintellectapi.wowfinstack.com/wp-json/wc/v3/products";

  /// Get Product List using page and per page parameters
  fetchProducts({required String page, required String perPage}) async {
    log("In ProductProvider | fetchProducts | Page: $page, Per Page: $perPage");
    Map<String, dynamic> fetchMap = {};
    List<Product> tempList = [];
    try {
      final res = await http.get(
        Uri.parse("$_baseUrl?page=$page&per_page=$perPage"),
        headers: {"Content-Type": "application/json"},
      );
      tempList = parseList(json.decode(res.body));
      setProductList(tempList);
      fetchMap = {"status": true, "list": tempList, "error": ""};
    } catch (err) {
      fetchMap = {"status": false, "list": [], "error": err.toString()};
    }
    log("Out ProductProvider | fetchProducts | Page: $page, Per Page: $perPage, Products Count: ${tempList.length}");
    return fetchMap;
  }

  parseList(List<dynamic> list) {
    log("In ProductProvider | parseList | List Length: ${list.length}");
    List<Product> tempList = [];
    for (var element in list) {
      Product product = Product.fromJson(element);
      tempList.add(product);
    }
    log("Out ProductProvider | parseList | List Length: ${list.length}");
    return tempList;
  }
}