import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tv_show.dart';

class PopularTVShowsPage extends StatefulWidget {
  @override
  _PopularTVShowsPage createState() => _PopularTVShowsPage();
}

class _PopularTVShowsPage extends State<PopularTVShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularTVShowsBloc>().add(FetchPopularTVShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(
          builder: (context, state) {
            if (state is PopularTVShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVShowsHasData) {
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
                child: Text((state as PopularTVShowsError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
