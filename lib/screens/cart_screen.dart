import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text('Your Order'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            }),
      ),
      body: Container(
        child: Center(
          child: Text('Your order page'),
        ),
      ),
    );
  }
}
