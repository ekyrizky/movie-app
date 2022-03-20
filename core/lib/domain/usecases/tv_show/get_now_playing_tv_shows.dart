import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingTVShows {
  final TVShowRepository repository;

  GetNowPlayingTVShows(this.repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return repository.getNowPlayingTVShows();
  }
}
