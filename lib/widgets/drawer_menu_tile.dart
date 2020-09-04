import 'package:flutter/material.dart';

class DrawerMenuTile extends StatelessWidget {
  final IconData icon;
  final String menuTitle;
  final String route;

  DrawerMenuTile(
      {@required this.icon, @required this.menuTitle, @required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(menuTitle),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }
}
