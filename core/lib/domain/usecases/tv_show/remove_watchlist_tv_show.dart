import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTvShow {
  final TVShowRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TVShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
