import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTvShow {
  final TVShowRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TVShowDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
