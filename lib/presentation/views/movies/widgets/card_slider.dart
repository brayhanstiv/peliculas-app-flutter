// Packages
import 'package:flutter/material.dart';

// Models
import 'package:peliculas/domain/models/response.model.dart';

// Views
import 'package:peliculas/presentation/views/movies/widgets/movie_paster.dart';

class CardSlider extends StatelessWidget {
  final List<Movie> movies;

  const CardSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Más películas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MoviePoster(
                  movie: movies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
