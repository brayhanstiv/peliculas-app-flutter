import 'package:flutter/material.dart';
import 'package:peliculas/models/response.model.dart';
import 'package:peliculas/providers/index.dart';
import 'package:peliculas/screens/index.dart';
import 'package:provider/provider.dart';

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
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    moviesProvider.getSuggestionsByQuery(query);
    if (query.isEmpty) {
      return const SizedBox(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 100,
          ),
        ),
      );
    }

    return StreamBuilder(
      stream: moviesProvider.suggetionsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Movie> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return MovieTile(
                movie: data[index],
              );
            },
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
