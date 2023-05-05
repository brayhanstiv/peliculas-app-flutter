// Packages
import 'package:flutter/material.dart';

// Models
import 'package:peliculas/domain/models/response.model.dart';

// Widgets
import 'package:peliculas/presentation/views/detail/widgets/poster_and_title.dart';
import 'package:peliculas/presentation/views/detail/widgets/custom_appbar.dart';
import 'package:peliculas/presentation/views/detail/widgets/overview.dart';
import 'package:peliculas/presentation/views/detail/widgets/card_casting.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            title: args.movie.title,
            image: args.movie.fullbackdropImg,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              PosterAndTitle(
                id: args.movie.id,
                title: args.movie.title,
                image: args.movie.fullPosterImg,
                subtitle: args.movie.originalTitle,
                rating: args.movie.voteAverage,
              ),
              OverView(description: args.movie.overview),
              OverView(description: args.movie.overview),
              OverView(description: args.movie.overview),
              CastingCards(
                id: args.movie.id,
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class DetailsScreenArguments {
  final Movie movie;

  DetailsScreenArguments({
    required this.movie,
  });
}
