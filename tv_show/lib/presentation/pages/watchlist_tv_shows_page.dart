import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tv_show.dart';

class WatchlistTVShowsPage extends StatefulWidget {
  @override
  _WatchlistTVShowsPage createState() => _WatchlistTVShowsPage();
}

class _WatchlistTVShowsPage extends State<WatchlistTVShowsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTVShowsBloc>().add(FetchTVShowWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTVShowsBloc>().add(FetchTVShowWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVShowsBloc, WatchlistTVShowsState>(
          builder: (context, state) {
            if (state is TVShowWatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVShowWatchlistHasData) {
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
            } else if (state is TVShowWatchlistEmpty) {
              return EmptyMessage(state: EmptyState.EmptyWatchlist);
            } else {
              return Center(
                child: Text(errorConnection),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
