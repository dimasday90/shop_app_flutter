import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* theme
import './util/constants/theme.dart';

//* pages
import './pages/splash_screen.dart';
import './pages/auth_page.dart';
import './pages/product_overview_page.dart';
import './pages/product_detail_page.dart';
import './pages/cart_page.dart';
import './pages/orders_page.dart';
import './pages/user_products_page.dart';
import './pages/edit_product_page.dart';

//* providers
import 'providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.userId,
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrders) => Orders(
            auth.userId,
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Day Shop',
          theme: theme,
          home: auth.isAuth
              ? ProductOverviewPage()
              : FutureBuilder(
                  future: auth.autoLoginCheck(),
                  builder: (ctx, result) =>
                      result.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthPage(),
                ),
          routes: {
            AuthPage.routeName: (ctx) => AuthPage(),
            ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            EditProductPage.routeName: (ctx) => EditProductPage(),
          },
        ),
      ),
    );
  }
}
