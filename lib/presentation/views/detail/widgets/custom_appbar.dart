// Packages
import 'package:flutter/material.dart';

// Constants
import 'package:peliculas/presentation/global/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title, image;

  const CustomAppBar({
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
