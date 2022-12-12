// Packages
import 'package:flutter/material.dart';
import 'package:peliculas/models/credits.model.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:peliculas/providers/movies.provider.dart';

class CastingCards extends StatelessWidget {
  final int id;

  const CastingCards({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(id),
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
                    (index) => _CastCard(
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

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({
    super.key,
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfileImg),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
