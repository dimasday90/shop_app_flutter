import 'package:flutter/material.dart';

//* models
import '../util/models/product.dart';

//* widgets
import '../widgets/product_card.dart';

//* dummy data
import '../util/dummies/products.dart';

class ProductOverviewPage extends StatelessWidget {
  final List<Product> products = dummyProducts;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: mediaQuery.size.height * 0.2,
            title: Text('Day Shop'),
            centerTitle: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductCard(
                    product: products[index],
                  );
                },
                childCount: products.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
