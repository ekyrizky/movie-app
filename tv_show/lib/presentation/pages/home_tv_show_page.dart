import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tv_show.dart';

class HomeTVShowPage extends StatefulWidget {
  @override
  _HomeTVShowPageState createState() => _HomeTVShowPageState();
}

class _HomeTVShowPageState extends State<HomeTVShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTVShowsBloc>().add(FetchNowPlayingTVShows());
      context.read<PopularTVShowsBloc>().add(FetchPopularTVShows());
      context.read<TopRatedTVShowsBloc>().add(FetchTopRatedTVShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing TV Shows',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(builder: (context, state) {
              if (state is NowPlayingTVShowsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTVShowsHasData) {
                return TVShowList(state.result);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Popular TV Shows',
              onTap: () => Navigator.pushNamed(context, toPopularTVShow),
            ),
            BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(builder: (context, state) {
              if (state is PopularTVShowsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTVShowsHasData) {
                return TVShowList(state.result);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Top Rated TV Shows',
              onTap: () => Navigator.pushNamed(context, toTopRatedTVShow),
            ),
            BlocBuilder<TopRatedTVShowsBloc, TopRatedTVShowsState>(builder: (context, state) {
              if (state is TopRatedTVShowsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTVShowsHasData) {
                return TVShowList(state.result);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TVShowList extends StatelessWidget {
  final List<TVShow> tvShows;

  TVShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return PosterImage(
            activeDrawerItem: DrawerItem.TVShow,
            routeNameDestination: toDetailTVShow,
            tvShow: tvShow,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
