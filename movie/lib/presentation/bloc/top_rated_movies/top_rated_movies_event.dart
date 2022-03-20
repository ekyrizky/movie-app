part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable {}

class FetchTopRatedMovies extends TopRatedMoviesEvent {
  @override
  List<Object> get props => [];
}
