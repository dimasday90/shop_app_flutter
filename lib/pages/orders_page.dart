import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/orders.dart' show Orders;

//*widgets
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) {
          return OrderItem(orderData.orders[index]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
