import 'package:flutter/material.dart';

//* theme
import './util/constants/theme.dart';

//* pages
import './pages/product_overview_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day Shop',
      theme: theme,
      home: ProductOverviewPage(),
    );
  }
}
