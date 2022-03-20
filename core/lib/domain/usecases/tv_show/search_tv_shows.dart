import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchTVShows {
  final TVShowRepository repository;

  SearchTVShows(this.repository);

  Future<Either<Failure, List<TVShow>>> execute(String query) {
    return repository.searchTVShows(query);
  }
}
