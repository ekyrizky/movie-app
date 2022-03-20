import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final genre = [
    const Genre(id: 1, name: 'genre1'),
  ];

  final genres = [
    const Genre(id: 1, name: 'genre1'),
    const Genre(id: 2, name: 'genre2'),
    const Genre(id: 3, name: 'genre3'),
  ];

  group('getGenres tests', () {
    test('should matches with expected one genre', () {
      const expectedString = 'genre1';
      final result = getGenres(genre);

      expect(result, expectedString);
    });

    test('should matches with expected multiple genre', () {
      const expectedString = 'genre1, genre2, genre3';
      final result1 = getGenres(genres);

      expect(result1, expectedString);
    });
  });

  group('getDuration tests', () {
    test('should matches with expected duration under 1 hours', () {
      const expected = '36m';
      final result = getDuration(36);

      expect(result, expected);
    });

    test('should matches with expected duration over 1 hours', () {
      const expected = '1h 22m';
      final result = getDuration(82);

      expect(result, expected);
    });
  });

  group('imageType tests', () {
    test('should matches with expected empty search image', () {
      const expected = 'assets/empty_search.png';
      final result = getImageType(EmptyState.EmptySearch);

      expect(result, expected);
    });

    test('should matches with expected empty watchlist image', () {
      const expected = 'assets/empty_watchlist.png';
      final result = getImageType(EmptyState.EmptyWatchlist);

      expect(result, expected);
    });
  });

  group('getEmptyMessage tests', () {
    test('should matches with expected empty search message', () {
      const expected = emptySearch;
      final result = getEmptyMessage(EmptyState.EmptySearch);

      expect(result, expected);
    });

    test('should matches with expected empty watchlist message', () {
      const expected = emptyWatchlist;
      final result = getEmptyMessage(EmptyState.EmptyWatchlist);

      expect(result, expected);
    });
  });
}
