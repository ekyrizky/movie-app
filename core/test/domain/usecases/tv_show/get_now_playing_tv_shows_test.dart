import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTVShows useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetNowPlayingTVShows(mockTVShowRepository);
  });

  final testTVShow = <TVShow>[];

  group("GetNowPlayingTVShows Tests", () {
    test('should get list of tv shows from the repository', () async {
      // arrange
      when(mockTVShowRepository.getNowPlayingTVShows()).thenAnswer((_) async => Right(testTVShow));
      // act
      final result = await useCase.execute();
      // assert
      expect(result, Right(testTVShow));
    });
  });
}
