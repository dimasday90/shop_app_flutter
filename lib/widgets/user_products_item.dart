import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/products.dart';

//* pages
import '../pages/edit_product_page.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  UserProductsItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
          scale: 10,
        ),
      ),
      title: Text(title),
      subtitle: Text('\$$price'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductPage.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          VerticalDivider(),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<Products>(context, listen: false)
                    .deleteProduct(id);
              } catch (error) {
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(SnackBar(
                  content: Text(error),
                ));
              }
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
