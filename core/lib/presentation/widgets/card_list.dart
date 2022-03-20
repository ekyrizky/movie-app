import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final Movie? movie;
  final TVShow? tvShow;
  final DrawerItem activeDrawerItem;
  final String routeName;

  const CardList({
    required this.activeDrawerItem,
    this.movie,
    this.tvShow,
    required this.routeName,
  });

  int _getId() => activeDrawerItem == DrawerItem.Movie ? movie?.id as int : tvShow?.id as int;

  String? _getTitle() => activeDrawerItem == DrawerItem.Movie ? movie?.title : tvShow?.name;

  String _getPosterPath() =>
      activeDrawerItem == DrawerItem.Movie ? movie?.posterPath as String : tvShow?.posterPath as String;

  String? _getOverview() => activeDrawerItem == DrawerItem.Movie ? movie?.overview : tvShow?.overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeName,
            arguments: _getId(),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTitle() ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _getOverview() ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${_getPosterPath()}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
