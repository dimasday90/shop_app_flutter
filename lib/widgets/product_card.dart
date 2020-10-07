import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

//* colors
import '../util/constants/colors.dart';

//* pages
import '../pages/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  void pushToDetail(BuildContext ctx, args) {
    Navigator.of(ctx).pushNamed(
      ProductDetailPage.routeName,
      arguments: args,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            pushToDetail(context, product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: bBlack54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: cFavorite,
              ),
              onPressed: () {
                product.toggleFavoriteStatus(auth.userId, auth.token);
              },
            ),
          ),
          title: Text(product.title),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(
                product.id,
                product.title,
                product.price,
                product.imageUrl,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.undoAddItem(product.id);
                      Scaffold.of(context).hideCurrentSnackBar();
                    },
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
