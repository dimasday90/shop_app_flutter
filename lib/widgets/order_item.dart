import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//* providers
import '../providers/orders.dart' as orderProvider;

class OrderItem extends StatefulWidget {
  final orderProvider.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Order Amount: \$${widget.order.amount}',
              ),
              subtitle: Text(
                DateFormat('EEE, dd/MM/yyyy hh:mm')
                    .format(widget.order.dateTime),
              ),
            ),
          ],
        ),
        children: widget.order.products.map((product) {
          return ListTile(
            contentPadding:
                EdgeInsets.only(top: 4, bottom: 4, left: 18, right: 12),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
            ),
            title: Text(
              product.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'subtotal: \$${product.price * product.quantity}',
            ),
            trailing: Text(
              '${product.quantity}x \$${product.price}',
            ),
          );
        }).toList(),
        maintainState: _expanded,
        onExpansionChanged: (_expanded) {
          return _expanded;
        },
      ),
    );
  }
}
