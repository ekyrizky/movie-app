import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVShowRecommendations useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetTVShowRecommendations(mockTVShowRepository);
  });

  final tId = 1;
  final testTVShows = <TVShow>[];

  test('should get list of tv show recommendations from the repository', () async {
    // arrange
    when(mockTVShowRepository.getTVShowRecommendations(tId)).thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testTVShows));
  });
}
