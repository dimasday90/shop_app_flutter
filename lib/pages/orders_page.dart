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
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.hasError) {
                return Center(child: Text('An error has occurred'));
              } else {
                return Consumer<Orders>(builder: (ctx, orderData, child) {
                  return ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, index) {
                      return OrderItem(orderData.orders[index]);
                    },
                  );
                });
              }
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
