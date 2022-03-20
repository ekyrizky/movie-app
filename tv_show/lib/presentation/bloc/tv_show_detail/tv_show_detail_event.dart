part of 'tv_show_detail_bloc.dart';

@immutable
abstract class TVShowDetailEvent extends Equatable {}

class FetchTVShowDetail extends TVShowDetailEvent {
  final int id;

  FetchTVShowDetail(this.id);

  @override
  List<Object> get props => [id];
}
