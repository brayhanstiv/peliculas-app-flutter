// Packages
import 'package:flutter/material.dart';

// Models
import 'package:peliculas/domain/models/response.model.dart';

// Views
import 'package:peliculas/presentation/views/detail/details_page.dart';

// Architecture
import 'package:peliculas/data/repositories_impl/movies_repository_impl.dart';
import 'package:peliculas/data/services/remote/movies_service.dart';
import 'package:peliculas/domain/repositories/movies_repository.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final MoviesRepository moviesRespository =
        MoviesRepositoryImpl(MoviesService());

    return GetSearch(moviesRespository: moviesRespository, query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final MoviesRepository moviesRespository =
        MoviesRepositoryImpl(MoviesService());

    return GetSearch(moviesRespository: moviesRespository, query: query);
  }
}

class GetSearch extends StatelessWidget {
  const GetSearch({
    super.key,
    required this.moviesRespository,
    required this.query,
  });

  final MoviesRepository moviesRespository;
  final String query;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesRespository.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Movie> data = snapshot.data!;
          if (data.isEmpty) {
            const SizedBox(
              child: Center(
                child: Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.black38,
                  size: 100,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return MovieTile(
                movie: data[index],
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SizedBox(
          child: Center(
            child: Icon(
              Icons.movie_creation_outlined,
              color: Colors.black38,
              size: 100,
            ),
          ),
        );
      },
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'search-${movie.id}',
        child: CircleAvatar(
          backgroundImage: NetworkImage(movie.fullPosterImg),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: DetailsScreenArguments(movie: movie),
        );
      },
    );
  }
}
