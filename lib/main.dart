// Packages
import 'package:flutter/material.dart';

// Common
import 'package:peliculas/common/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      theme: themeLight,
      initialRoute: '/home',
      routes: routes,
    );
  }
}
