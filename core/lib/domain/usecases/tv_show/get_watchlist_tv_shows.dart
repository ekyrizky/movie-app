import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTVShows {
  final TVShowRepository _repository;

  GetWatchlistTVShows(this._repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return _repository.getWatchlistTVShows();
  }
}
