// Packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Models
import 'package:peliculas/models/response.model.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '3c71e7ec87707e750f3408b1cfca9937';
  final String language = 'es-ES';

  List<Movie> mainMovies = [];
  List<Movie> popularMovies = [];

  int popularPage = 0;

  MoviesProvider() {
    getMainMovies();
    getPopularMovies();
  }

  Uri getUrl(String url, {int page = 1}) {
    Uri uri = Uri.https(_baseUrl, '3/movie/$url', {
      'api_key': _apiKey,
      'language': language,
      'page': page.toString(),
    });

    return uri;
  }

  void getMainMovies() async {
    try {
      Uri url = getUrl('now_playing');
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
      Uri url = getUrl('popular', page: popularPage);
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
}
