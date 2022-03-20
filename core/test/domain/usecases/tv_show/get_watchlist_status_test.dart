import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTVShow useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetWatchListStatusTVShow(mockTVShowRepository);
  });

  test('should get watchlist status of tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await useCase.execute(1);
    // assert
    expect(result, true);
  });
}
