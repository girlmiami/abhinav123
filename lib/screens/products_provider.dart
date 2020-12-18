import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    const url =
        'https://ecommerce-d87c2-default-rtdb.firebaseio.com/Products.json';
    http.post(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }));
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
  }
}
