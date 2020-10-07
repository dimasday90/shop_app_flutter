import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/products.dart';

class ProductDetailPage extends StatelessWidget {
  static const String routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(14),
                child: Text(
                  '\$${loadedProduct.price}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(
                  '${loadedProduct.description}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
