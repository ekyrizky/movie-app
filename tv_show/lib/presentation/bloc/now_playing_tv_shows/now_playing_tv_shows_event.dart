part of 'now_playing_tv_shows_bloc.dart';

@immutable
abstract class NowPlayingTVShowsEvent extends Equatable {}

class FetchNowPlayingTVShows extends NowPlayingTVShowsEvent {
  @override
  List<Object> get props => [];
}
