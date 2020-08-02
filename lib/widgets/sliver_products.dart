import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//*widgets
import './product_card.dart';

//* providers
import '../providers/products.dart';

class SliverProducts extends StatelessWidget {
  final bool showFavorites;

  SliverProducts(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsState = Provider.of<Products>(context);
    final productItems =
        showFavorites ? productsState.favoriteItems : productsState.items;
    return SliverPadding(
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
            return ChangeNotifierProvider.value(
              value: productItems[index],
              child: ProductCard(),
            );
          },
          childCount: productItems.length,
        ),
      ),
    );
  }
}
