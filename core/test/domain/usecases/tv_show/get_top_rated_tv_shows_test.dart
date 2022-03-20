import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVShows useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetTopRatedTVShows(mockTVShowRepository);
  });

  final testTVShow = <TVShow>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTVShowRepository.getTopRatedTVShows()).thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}
