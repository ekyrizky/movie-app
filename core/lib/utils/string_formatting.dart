import 'package:core/core.dart';

String getGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += genre.name + ', ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String getDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}

String getImageType(state) {
  if (state == EmptyState.EmptySearch) {
    return 'assets/empty_search.png';
  } else if (state == EmptyState.EmptyWatchlist) {
    return 'assets/empty_watchlist.png';
  } else {
    return 'assets/no_data.png';
  }
}

String getEmptyMessage(state) {
  if (state == EmptyState.EmptySearch) {
    return emptySearch;
  } else if (state == EmptyState.EmptyWatchlist) {
    return emptyWatchlist;
  } else {
    return errorConnection;
  }
}
