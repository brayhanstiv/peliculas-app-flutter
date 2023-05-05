// Packages
import 'package:flutter/material.dart';

// Pages
import 'package:peliculas/presentation/views/index.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/home': (context) => const HomePage(),
  '/movies': (context) => const MoviesPage(),
  '/detail': (context) => const DetailPage(),
};
