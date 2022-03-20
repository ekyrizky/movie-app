import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tv_show.dart';

class TopRatedTVShowsPage extends StatefulWidget {
  @override
  _TopRatedTVShowsPage createState() => _TopRatedTVShowsPage();
}

class _TopRatedTVShowsPage extends State<TopRatedTVShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TopRatedTVShowsBloc>(context, listen: false).add(FetchTopRatedTVShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVShowsBloc, TopRatedTVShowsState>(
          builder: (context, state) {
            if (state is TopRatedTVShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVShowsHasData) {
              final tvShows = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = tvShows[index];
                  return CardList(
                    activeDrawerItem: DrawerItem.TVShow,
                    routeName: toDetailTVShow,
                    tvShow: tvShow,
                  );
                },
                itemCount: tvShows.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TopRatedTVShowsError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
