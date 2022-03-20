import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetPopularTVShows {
  final TVShowRepository repository;

  GetPopularTVShows(this.repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return repository.getPopularTVShows();
  }
}
