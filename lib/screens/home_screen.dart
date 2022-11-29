// Packages
import 'package:flutter/material.dart';

// Widgets
import 'package:peliculas/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Card Swipper
            CardSwipper(),
            // Listado horizontal de peliculas
            CardSlider(),
            CardSlider(),
            CardSlider(),
            CardSlider(),
          ],
        ),
      ),
    );
  }
}
