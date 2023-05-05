// Packages
import 'package:flutter/material.dart';

// Architecture
import 'package:peliculas/data/repositories_impl/movies_repository_impl.dart';
import 'package:peliculas/data/services/remote/movies_service.dart';
import 'package:peliculas/domain/repositories/movies_repository.dart';

// Models
import 'package:peliculas/domain/models/genres.model.dart';
import 'package:peliculas/presentation/views/home/widgets/genre_card.dart';

// Widgets
import 'package:peliculas/presentation/widgets/search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesRepository moviesRespository =
        MoviesRepositoryImpl(MoviesService());
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
        future: moviesRespository.getGenres(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Genre> genres = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      genres.length,
                      (index) => GenreCard(genre: genres[index]),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Text(
            'Ha ocurrido un error, por favor inténtalo de nuevo más tarde',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.3,
              color: Colors.black54,
              fontSize: 20,
            ),
          );
        },
      ),
    );
  }
}
