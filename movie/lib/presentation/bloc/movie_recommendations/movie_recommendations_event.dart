part of 'movie_recommendations_bloc.dart';

@immutable
abstract class MovieRecommendationsEvent extends Equatable {}

class FetchMovieRecommendations extends MovieRecommendationsEvent {
  final int id;

  FetchMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
