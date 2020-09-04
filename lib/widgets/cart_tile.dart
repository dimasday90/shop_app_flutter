import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/cart.dart';

//* colors
import '../util/constants/colors.dart';

class CartTile extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartTile({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.imageUrl,
    @required this.price,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text('Delete Item'),
                  content: Text('Are you sure to delete $title item(s)?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text(
                        'No',
                      ),
                      textColor: bBlue900,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text(
                        'Yes',
                      ),
                      textColor: Theme.of(context).errorColor,
                    ),
                  ],
                );
              });
        }
      },
      onDismissed: (_) {
        cart.removeItem(productId);
      },
      background: Container(
        padding: EdgeInsets.only(
          right: 20,
        ),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: cWhite,
        ),
        color: Theme.of(context).errorColor,
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: Padding(
          padding: EdgeInsets.all(6.3),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            // leading: ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Image.network(
            //     imageUrl,
            //     fit: BoxFit.cover,
            //     width: MediaQuery.of(context).size.width * 0.2,
            //   ),
            // ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            subtitle: Text('subtotal: \$${price * quantity}'),
            trailing: RichText(
              softWrap: true,
              text: TextSpan(
                  text: '\$$price |',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: ' $quantity x',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
