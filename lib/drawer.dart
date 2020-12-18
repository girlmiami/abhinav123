import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello there!'),
            backgroundColor: Colors.amber[900],
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
          // Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/cart');
            },
            leading: Icon(
              Icons.shopping_cart,
            ),
            title: Text(
              'Your Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/addproduct');
            },
            leading: Icon(
              Icons.shopping_basket,
            ),
            title: Text(
              'Add Product',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
