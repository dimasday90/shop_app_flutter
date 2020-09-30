import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/cart.dart';
import '../providers/orders.dart';

//* widgets
import '../widgets/cart_tile.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cart.items.length > 0
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      return CartTile(
                        id: cart.items.values.toList()[index].id,
                        productId: cart.items.keys.toList()[index],
                        title: cart.items.values.toList()[index].title,
                        imageUrl: cart.items.values.toList()[index].imageUrl,
                        price: cart.items.values.toList()[index].price,
                        quantity: cart.items.values.toList()[index].quantity,
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Chip(
                          label: Text(
                            '\$${cart.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    .color),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        OrderButton(cart: cart, orders: orders),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'Your cart is empty. Add one now!',
              ),
            ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.orders,
  }) : super(key: key);

  final Cart cart;
  final Orders orders;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalPrice <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.orders.addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalPrice);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      child: Text(
        'ORDER NOW',
        style: TextStyle(
          fontFamily: 'Anton',
          fontSize: 16,
        ),
      ),
      textColor: Theme.of(context).accentColor,
    );
  }
}
