// Packages
import 'package:flutter/material.dart';

// Common
import 'package:peliculas/common/index.dart';

// Models
import 'package:peliculas/models/response.model.dart';

// Widgets
import 'package:peliculas/widgets/index.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            title: args.movie.title,
            image: args.movie.fullbackdropImg,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                id: args.movie.id,
                title: args.movie.title,
                image: args.movie.fullPosterImg,
                subtitle: args.movie.originalTitle,
                rating: args.movie.voteAverage,
              ),
              _OverView(description: args.movie.overview),
              _OverView(description: args.movie.overview),
              _OverView(description: args.movie.overview),
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

class _CustomAppBar extends StatelessWidget {
  final String title, image;

  const _CustomAppBar({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(image),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final int id;
  final String title, image;
  final String? subtitle;
  final double? rating;

  const _PosterAndTitle({
    super.key,
    required this.id,
    required this.title,
    this.subtitle,
    required this.image,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(image),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width - 190,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width - 190,
                ),
                child: Text(
                  subtitle ?? '',
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    rating != null ? rating.toString() : '',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final String description;

  const _OverView({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
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
