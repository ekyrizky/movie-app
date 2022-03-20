part of 'tv_show_recommendations_bloc.dart';

@immutable
abstract class TVShowRecommendationsEvent extends Equatable {}

class FetchTVShowRecommendations extends TVShowRecommendationsEvent {
  final int id;

  FetchTVShowRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
