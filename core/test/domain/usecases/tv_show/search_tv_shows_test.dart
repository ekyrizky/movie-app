import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVShows useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = SearchTVShows(mockTVShowRepository);
  });

  final testTVShows = <TVShow>[];
  final tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.searchTVShows(tQuery)).thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(testTVShows));
  });
}
