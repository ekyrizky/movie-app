import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';

class SearchPage extends StatelessWidget {
  final DrawerItem activeDrawerItem;

  SearchPage({
    Key? key,
    required this.activeDrawerItem,
  }) : super(key: key);

  late String _title;

  @override
  Widget build(BuildContext context) {
    _title = activeDrawerItem == DrawerItem.Movie ? "Movie" : "TV Show";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Search $_title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (activeDrawerItem == DrawerItem.Movie) {
                  context.read<SearchMoviesBloc>().add(OnQueryMoviesChange(query));
                } else
                  context.read<SearchTVShowsBloc>().add(OnQueryTVShowsChange(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            _buildSearchResults()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (activeDrawerItem == DrawerItem.Movie) {
      return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        key: const Key('search_movies'),
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchMoviesHasData) {
            final movies = state.result;
            return _buildMovieCardList(movies);
          } else if (state is SearchMoviesEmpty) {
            return _buildMovieCardList([]);
          } else if (state is SearchMoviesError) {
            return EmptyMessage(state: EmptyState.EmptySearch);
          } else {
            return Container();
          }
        },
      );
    } else {
      return BlocBuilder<SearchTVShowsBloc, SearchTVShowsState>(
        key: const Key('search_tv_shows'),
        builder: (context, state) {
          if (state is SearchTVShowsLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchTVShowsHasData) {
            final tvShows = state.result;
            return _buildTVShowCardList(tvShows);
          } else if (state is SearchTVShowsEmpty) {
            return _buildTVShowCardList([]);
          } else if (state is SearchTVShowsError) {
            return EmptyMessage(state: EmptyState.EmptySearch);
          } else {
            return Container();
          }
        },
      );
    }
  }

  Widget _buildMovieCardList(List<Movie> movies) {
    if (movies.isEmpty) return EmptyMessage(state: EmptyState.EmptySearch);

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return CardList(
            movie: movie,
            activeDrawerItem: activeDrawerItem,
            routeName: toDetailMovie,
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _buildTVShowCardList(List<TVShow> tvShows) {
    if (tvShows.isEmpty)
      return EmptyMessage(
        state: EmptyState.EmptySearch,
      );

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return CardList(
            tvShow: tvShow,
            activeDrawerItem: activeDrawerItem,
            routeName: toDetailTVShow,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
