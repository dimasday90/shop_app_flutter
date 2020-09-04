import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* providers
import '../providers/products.dart';

//* widgets
import '../widgets/user_products_item.dart';
import '../widgets/app_drawer.dart';

//* pages
import './edit_product_page.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final items = products.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 14,
        ),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            return UserProductsItem(
              id: items[index].id,
              title: items[index].title,
              price: items[index].price,
              imageUrl: items[index].imageUrl,
            );
          },
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
