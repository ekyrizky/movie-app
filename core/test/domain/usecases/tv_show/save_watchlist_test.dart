import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvShow useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = SaveWatchlistTvShow(mockTVShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTVShowRepository.saveWatchlist(testTVShowDetail)).thenAnswer((_) async => Right(watchlistAddMessage));
    // act
    final result = await useCase.execute(testTVShowDetail);
    // assert
    verify(mockTVShowRepository.saveWatchlist(testTVShowDetail));
    expect(result, Right(watchlistAddMessage));
  });
}
