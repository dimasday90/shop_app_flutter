import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//*pages
import './cart_page.dart';

//* widgets
import '../widgets/sliver_products.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

//* enums
import '../util/constants/enum.dart';

//* providers
import '../providers/cart.dart';

class ProductOverviewPage extends StatefulWidget {
  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: mediaQuery.size.height * 0.2,
            floating: false,
            pinned: true,
            snap: false,
            title: Text('Day Shop'),
            centerTitle: true,
            actions: <Widget>[
              Consumer<Cart>(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartPage.routeName);
                  },
                ),
                builder: (context, cart, child) => Badge(
                  child: child,
                  value: cart.itemCount.toString(),
                ),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    if (value == FilterOptions.showFavorites) {
                      _showFavorites = true;
                    } else {
                      _showFavorites = false;
                    }
                  });
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.showAll,
                  ),
                  PopupMenuItem(
                    child: Text('Show Favorites'),
                    value: FilterOptions.showFavorites,
                  ),
                ],
              ),
            ],
          ),
          SliverProducts(_showFavorites),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
