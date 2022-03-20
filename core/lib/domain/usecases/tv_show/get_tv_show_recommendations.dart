import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTVShowRecommendations {
  final TVShowRepository repository;

  GetTVShowRecommendations(this.repository);

  Future<Either<Failure, List<TVShow>>> execute(id) {
    return repository.getTVShowRecommendations(id);
  }
}
