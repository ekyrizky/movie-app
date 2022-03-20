import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvShow useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = RemoveWatchlistTvShow(mockTVShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.removeWatchlist(testTVShowDetail)).thenAnswer((_) async => Right(watchlistRemoveMessage));
    // act
    final result = await useCase.execute(testTVShowDetail);
    // assert
    verify(mockTVShowRepository.removeWatchlist(testTVShowDetail));
    expect(result, Right(watchlistRemoveMessage));
  });
}
