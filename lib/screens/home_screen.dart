// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:peliculas/providers/movies.provider.dart';

// Widgets
import 'package:peliculas/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Card Swipper
            CardSwipper(
              movies: moviesProvider.mainMovies,
            ),
            // Listado horizontal de peliculas
            CardSlider(
              movies: moviesProvider.popularMovies,
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
