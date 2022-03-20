import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PosterImage extends StatelessWidget {
  final Movie? movie;
  final TVShow? tvShow;
  final DrawerItem activeDrawerItem;
  final String routeNameDestination;

  const PosterImage({
    Key? key,
    required this.activeDrawerItem,
    required this.routeNameDestination,
    this.movie,
    this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = activeDrawerItem == DrawerItem.Movie ? movie?.id : tvShow?.id as int;
    final posterPath = activeDrawerItem == DrawerItem.Movie ? movie?.posterPath : tvShow?.posterPath as String;
    return Container(
        padding: const EdgeInsets.all(8),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                routeNameDestination,
                arguments: id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL$posterPath',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ));
  }
}
