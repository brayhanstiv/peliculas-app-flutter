// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Common
import 'package:peliculas/common/index.dart';

// Providers
import 'package:peliculas/providers/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas',
        theme: themeLight,
        initialRoute: '/home',
        routes: routes,
      ),
    );
  }
}
