// Packages
import 'package:flutter/material.dart';
import 'package:peliculas/screens/index.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/home': (context) => const HomeScreen(),
  '/detail': (context) => const DetailsScreen(),
};
