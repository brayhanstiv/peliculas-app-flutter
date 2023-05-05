// Packages
import 'package:flutter/material.dart';

// Models
import 'package:peliculas/domain/models/response.model.dart';

// Views
import 'package:peliculas/presentation/views/detail/details_page.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: DetailsScreenArguments(movie: movie),
            ),
            child: Hero(
              tag: 'swiper-${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.contain,
                  width: 130,
                  height: 170,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
