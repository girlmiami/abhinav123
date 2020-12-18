
import 'package:abhinav123/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text(
          'Fashion Bazaar',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/cart');
              })
        ],
      ),
      drawer: AppDrawer(),
      body: ProductDetailScreen(),
    );
  }
}
