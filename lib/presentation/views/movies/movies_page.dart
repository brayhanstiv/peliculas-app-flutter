// Packages
import 'package:flutter/material.dart';

// Architecture
import 'package:peliculas/data/repositories_impl/movies_repository_impl.dart';
import 'package:peliculas/data/services/remote/movies_service.dart';
import 'package:peliculas/domain/repositories/movies_repository.dart';

// Models
import 'package:peliculas/domain/models/response.model.dart';

// Widgets
import 'package:peliculas/presentation/views/movies/widgets/card_slider.dart';
import 'package:peliculas/presentation/views/movies/widgets/card_swipper.dart';
import 'package:peliculas/presentation/widgets/search_delegate.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesRepository moviesRespository =
        MoviesRepositoryImpl(MoviesService());
    final MoviesScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as MoviesScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: MovieSearchDelegate(),
            ),
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: moviesRespository.getMovies(args.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Movie> movies = snapshot.data!;
            if (snapshot.data!.length < 5) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.error_outline,
                    color: Colors.black54,
                    size: 100,
                  ),
                  Text(
                    'Ha ocurrido un error, por favor inténtalo de nuevo más tarde',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            }

            List<Movie> swipperMovies = movies.sublist(0, 5);
            List<Movie> sliderMovies = movies.sublist(5, 20);
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Card Swipper
                  CardSwipper(movies: swipperMovies),
                  // Listado horizontal de peliculas
                  CardSlider(
                    movies: sliderMovies,
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.error_outline,
                color: Colors.black54,
                size: 100,
              ),
              Text(
                'Ha ocurrido un error, por favor inténtalo de nuevo más tarde',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.3,
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MoviesScreenArguments {
  final int id;

  MoviesScreenArguments({
    required this.id,
  });
}
