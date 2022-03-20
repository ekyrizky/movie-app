import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
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
              'Now Playing Movies',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(builder: (context, state) {
              if (state is NowPlayingMoviesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMoviesHasData) {
                return MovieList(state.result);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Popular Movies',
              onTap: () => Navigator.pushNamed(context, toPopularMovie),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(builder: (context, state) {
              if (state is PopularMoviesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMoviesHasData) {
                return MovieList(state.result);
              } else {
                return Text('Failed');
              }
            }),
            SubHeading(
              title: 'Top Rated Movies',
              onTap: () => Navigator.pushNamed(context, toTopRatedMovie),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(builder: (context, state) {
              if (state is TopRatedMoviesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMoviesHasData) {
                return MovieList(state.result);
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return PosterImage(
            activeDrawerItem: DrawerItem.Movie,
            routeNameDestination: toDetailMovie,
            movie: movie,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
