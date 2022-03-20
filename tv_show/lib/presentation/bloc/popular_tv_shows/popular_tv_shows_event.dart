part of 'popular_tv_shows_bloc.dart';

@immutable
abstract class PopularTVShowsEvent extends Equatable {}

class FetchPopularTVShows extends PopularTVShowsEvent {
  @override
  List<Object> get props => [];
}
