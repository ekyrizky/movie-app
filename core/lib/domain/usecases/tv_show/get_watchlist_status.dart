import 'package:core/core.dart';

class GetWatchListStatusTVShow {
  final TVShowRepository repository;

  GetWatchListStatusTVShow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
