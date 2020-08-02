import 'package:flutter/material.dart';

//* colors
import '../util/constants/colors.dart';

//* models
import '../util/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: bBlack54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(product.title),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
