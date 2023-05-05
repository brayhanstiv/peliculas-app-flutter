import 'package:flutter/material.dart';

class PosterAndTitle extends StatelessWidget {
  final int id;
  final String title, image;
  final String? subtitle;
  final double? rating;

  const PosterAndTitle({
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
                  style: Theme.of(context).textTheme.headlineSmall,
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
                  style: Theme.of(context).textTheme.titleMedium,
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
                    style: Theme.of(context).textTheme.bodySmall,
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
