import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_show/tv_show.dart';

class TVShowDetailPage extends StatefulWidget {
  final int id;

  TVShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVShowDetailPage createState() => _TVShowDetailPage();
}

class _TVShowDetailPage extends State<TVShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVShowDetailBloc>().add(FetchTVShowDetail(widget.id));
      context.read<TVShowRecommendationsBloc>().add(FetchTVShowRecommendations(widget.id));
      context.read<WatchlistTVShowsBloc>().add(FetchWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist = context.select<WatchlistTVShowsBloc, bool>(
        (bloc) => (bloc.state is TVShowIsAddedToWatchlist) ? (bloc.state as TVShowIsAddedToWatchlist).isAdded : false);
    return Scaffold(
      body: BlocBuilder<TVShowDetailBloc, TVShowDetailState>(
        builder: (context, state) {
          if (state is TVShowDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVShowDetailHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(
                movie,
                isAddedToWatchlist,
              ),
            );
          } else {
            return Center(
              child: Text(errorConnection),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVShowDetail tvShow;
  final bool isAddedWatchlist;

  const DetailContent(this.tvShow, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  late bool isAddedToWatchlist = widget.isAddedWatchlist;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvShow.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedToWatchlist) {
                                  context.read<WatchlistTVShowsBloc>().add(AddTVShowToWatchlist(widget.tvShow));
                                } else {
                                  context.read<WatchlistTVShowsBloc>().add(RemoveTVShowFromWatchlist(widget.tvShow));
                                }

                                final state = BlocProvider.of<WatchlistTVShowsBloc>(context).state;
                                String message = "";

                                if (state is TVShowIsAddedToWatchlist) {
                                  final isAdded = state.isAdded;
                                  message = isAdded == false ? watchlistAddMessage : watchlistRemoveMessage;
                                } else {
                                  message = !isAddedToWatchlist ? watchlistAddMessage : watchlistRemoveMessage;
                                }

                                if (message == watchlistAddMessage || message == watchlistRemoveMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  isAddedToWatchlist = !isAddedToWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              getGenres(widget.tvShow.genres),
                            ),
                            Text(
                              widget.tvShow.episodeRunTime.isNotEmpty
                                  ? getDuration(widget.tvShow.episodeRunTime[0])
                                  : 'N/A',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvShow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Episodes: ${widget.tvShow.numberOfEpisodes}',
                            ),
                            Text(
                              'Seasons: ${widget.tvShow.numberOfSeasons}',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvShow.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVShowRecommendationsBloc, TVShowRecommendationsState>(
                              builder: (context, state) {
                                if (state is TVShowRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TVShowRecommendationsError) {
                                  return Text(state.message);
                                } else if (state is TVShowRecommendationsHasData) {
                                  final recommendationTvShows = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = recommendationTvShows[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                toDetailTVShow,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                                                placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendationTvShows.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
