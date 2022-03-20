import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTVShowDetail {
  final TVShowRepository repository;

  GetTVShowDetail(this.repository);

  Future<Either<Failure, TVShowDetail>> execute(int id) {
    return repository.getTVShowDetail(id);
  }
}
