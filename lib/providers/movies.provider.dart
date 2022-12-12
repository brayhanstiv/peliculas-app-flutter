// Packages
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';

// Models
import 'package:peliculas/models/credits.model.dart';
import 'package:peliculas/models/response.model.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '3c71e7ec87707e750f3408b1cfca9937';
  final String language = 'es-ES';

  List<Movie> mainMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int popularPage = 0;

  Debouncer debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggetionsStream =>
      this._suggestionsStreamController.stream;

  MoviesProvider() {
    getMainMovies();
    getPopularMovies();
  }

  Uri getUrl(
    String url, {
    int page = 1,
    String? query,
  }) {
    Uri uri = Uri.https(_baseUrl, '3/$url', {
      'api_key': _apiKey,
      'language': language,
      'page': page.toString(),
      'query': query ?? ''
    });

    return uri;
  }

  void getMainMovies() async {
    try {
      Uri url = getUrl('movie/now_playing');
      http.Response response = await http.get(url);
      Response data = Response.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        mainMovies = data.results;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getPopularMovies() async {
    popularPage++;
    try {
      Uri url = getUrl('movie/popular', page: popularPage);
      http.Response response = await http.get(url);
      Response data = Response.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        popularMovies = [...popularMovies, ...data.results];
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }
    try {
      Uri url = getUrl('movie/$movieId/credits');
      http.Response response = await http.get(url);
      Credits data = Credits.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        moviesCast[movieId] = data.cast;
        notifyListeners();
      }
      return data.cast;
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

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final data = await searchMovies(query);
      _suggestionsStreamController.add(data);
    };
    final Timer timer =
        Timer.periodic(const Duration(milliseconds: 300), (timer) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(microseconds: 301))
        .then((value) => timer.cancel());
  }
}
