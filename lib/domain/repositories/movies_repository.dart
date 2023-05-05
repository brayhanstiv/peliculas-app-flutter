// Models
import 'package:peliculas/domain/models/credits.model.dart';
import 'package:peliculas/domain/models/genres.model.dart';
import 'package:peliculas/domain/models/response.model.dart';

abstract class MoviesRepository {
  Future<List<Genre>> getGenres();
  Future<List<Movie>> getMovies(String id);
  Future<List<Cast>> getMovieCast(String id);
  Future<List<Movie>> searchMovies(String query);
}
