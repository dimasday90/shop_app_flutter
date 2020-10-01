import 'package:flutter/material.dart';

class DrawerMenuTile extends StatelessWidget {
  final IconData icon;
  final String menuTitle;
  final String route;
  final Function onTapHandler;

  DrawerMenuTile(
      {@required this.icon,
      @required this.menuTitle,
      this.route,
      this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(menuTitle),
      onTap: route == null
          ? onTapHandler
          : () {
              Navigator.of(context).pushReplacementNamed(route);
            },
    );
  }
}
