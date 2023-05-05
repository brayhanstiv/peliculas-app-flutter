// Models
import 'package:peliculas/domain/models/genres.model.dart';
import 'package:peliculas/domain/models/response.model.dart';
import 'package:peliculas/domain/models/credits.model.dart';

// Repository
import 'package:peliculas/domain/repositories/movies_repository.dart';

// Services
import 'package:peliculas/data/services/remote/movies_service.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesService moviesService;

  MoviesRepositoryImpl(this.moviesService);

  @override
  Future<List<Movie>> getMovies(String id) {
    return moviesService.getMovies(id);
  }

  @override
  Future<List<Cast>> getMovieCast(String id) {
    return moviesService.getMovieCast(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return moviesService.searchMovies(query);
  }

  @override
  Future<List<Genre>> getGenres() {
    return moviesService.getGenres();
  }
}
