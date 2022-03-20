import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTVShows {
  final TVShowRepository repository;

  GetTopRatedTVShows(this.repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return repository.getTopRatedTVShows();
  }
}
