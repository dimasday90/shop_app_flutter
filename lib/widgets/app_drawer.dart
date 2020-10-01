import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* pages
import '../pages/orders_page.dart';
import '../pages/user_products_page.dart';

//* widgets
import './drawer_menu_tile.dart';

//* providers
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome to Day Shop'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          DrawerMenuTile(
            icon: Icons.shopping_cart,
            menuTitle: 'Shop',
            route: '/',
          ),
          Divider(),
          DrawerMenuTile(
            icon: Icons.payment,
            menuTitle: 'Orders',
            route: OrdersPage.routeName,
          ),
          Divider(),
          DrawerMenuTile(
            icon: Icons.mode_edit,
            menuTitle: 'Products',
            route: UserProductsPage.routeName,
          ),
          Divider(),
          DrawerMenuTile(
            icon: Icons.exit_to_app,
            menuTitle: 'Logout',
            onTapHandler: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
