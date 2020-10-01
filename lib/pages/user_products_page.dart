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

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshotData) =>
            snapshotData.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(ctx),
                    child: Consumer<Products>(
                      builder: (ctx, products, _) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 14,
                        ),
                        child: ListView.builder(
                          itemCount: products.items.length,
                          itemBuilder: (_, index) {
                            return UserProductsItem(
                              id: products.items[index].id,
                              title: products.items[index].title,
                              price: products.items[index].price,
                              imageUrl: products.items[index].imageUrl,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
