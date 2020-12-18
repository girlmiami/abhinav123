
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../product_items.dart';

class ProductDetailScreen extends StatelessWidget {
  final List<Product> productList = [
    Product(
      id: 'p1',
      title: 'Watch',
      description: 'A Classic Men\'s Watch',
      price: 229.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/wadry-b5710.appspot.com/o/images%2Fcap-300x300.png?alt=media&token=f084172c-fb9a-4bb3-8dc5-b6227449bd85',
    ),
    Product(
      id: 'p2',
      title: 'Laptop',
      description: 'Mac Book Pro',
      price: 959.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/wadry-b5710.appspot.com/o/images%2Fcap-300x300.png?alt=media&token=f084172c-fb9a-4bb3-8dc5-b6227449bd85',
    ),
    Product(
      id: 'p3',
      title: 'Mobile',
      description: 'iPhone x 64GB',
      price: 619.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/wadry-b5710.appspot.com/o/images%2Fcap-300x300.png?alt=media&token=f084172c-fb9a-4bb3-8dc5-b6227449bd85',
    ),
    Product(
      id: 'p4',
      title: 'HeadPhones',
      description: 'Beats Pro ultra Sonic dolby atmos',
      price: 249.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/wadry-b5710.appspot.com/o/images%2Fcap-300x300.png?alt=media&token=f084172c-fb9a-4bb3-8dc5-b6227449bd85',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: productList.length,
        itemBuilder: (ctx, i) => ProductItem(
          productList[i].id,
          productList[i].title,
          productList[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
