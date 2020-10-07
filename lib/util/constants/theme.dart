import 'package:flutter/material.dart';
import './colors.dart';
import '../helpers/custom_route.dart';

ThemeData theme = ThemeData(
    primarySwatch: cOrange,
    accentColor: cDeepOrange,
    fontFamily: 'Lato',
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    }));
