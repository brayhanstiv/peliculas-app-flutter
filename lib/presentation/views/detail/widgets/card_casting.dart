// Packages
import 'package:flutter/material.dart';

// Architecture
import 'package:peliculas/data/repositories_impl/movies_repository_impl.dart';
import 'package:peliculas/data/services/remote/movies_service.dart';
import 'package:peliculas/domain/repositories/movies_repository.dart';

// Models
import 'package:peliculas/domain/models/credits.model.dart';

// Widgets
import 'package:peliculas/presentation/views/detail/widgets/card_cast.dart';

class CastingCards extends StatelessWidget {
  final int id;

  const CastingCards({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final MoviesRepository moviesRespository =
        MoviesRepositoryImpl(MoviesService());

    return FutureBuilder(
      future: moviesRespository.getMovieCast(id.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Cast> data = snapshot.data!;
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    data.length,
                    (index) => CastCard(
                      actor: data[index],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        return const SizedBox(
          child: Text('error bringing data'),
        );
      },
    );
  }
}
