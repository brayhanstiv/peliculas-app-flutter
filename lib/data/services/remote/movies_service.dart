// Packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Models
import 'package:peliculas/domain/models/credits.model.dart';
import 'package:peliculas/domain/models/genres.model.dart';
import 'package:peliculas/domain/models/response.model.dart';

class MoviesService {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'fd4c25c2f0665141e89d2d389472f84e';
  final String language = 'es-ES';

  Uri getUrl(
    String url, {
    int page = 1,
    String? query,
    String? genre,
  }) {
    Uri uri = Uri.https(_baseUrl, '3/$url', {
      'api_key': _apiKey,
      'language': language,
      'page': page.toString(),
      'query': query ?? '',
      'with_genres': genre ?? ''
    });

    return uri;
  }

  Future<List<Genre>> getGenres() async {
    try {
      Uri url = getUrl('genre/movie/list');
      http.Response response = await http.get(url);
      Genres data = Genres.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        List<Genre> genres = data.genres;
        return genres;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Movie>> getMovies(String id) async {
    try {
      Uri url = getUrl('discover/movie', genre: id);
      http.Response response = await http.get(url);
      Response data = Response.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        List<Movie> movies = data.results;
        return movies;
      }

      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Cast>> getMovieCast(String movieId) async {
    try {
      Uri url = getUrl('movie/$movieId/credits');
      http.Response response = await http.get(url);
      Credits data = Credits.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        List<Cast> casts = data.cast;
        return casts;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      Uri url = getUrl('search/movie', query: query);
      http.Response response = await http.get(url);
      Response data = Response.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return data.results;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
