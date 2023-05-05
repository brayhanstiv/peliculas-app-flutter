// Packages
import 'package:flutter/material.dart';

// Modles
import 'package:peliculas/domain/models/genres.model.dart';
import 'package:peliculas/presentation/views/index.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;

  const GenreCard({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/movies',
        arguments: MoviesScreenArguments(id: genre.id),
      ),
      child: SizedBox(
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/no-image.jpg'),
              fit: BoxFit.contain,
              width: size.width * 0.4,
            ),
            Text(genre.name),
          ],
        ),
      ),
    );
  }
}
