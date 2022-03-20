import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVShows useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetPopularTVShows(mockTVShowRepository);
  });

  final testTVShow = <TVShow>[];

  test('should get list of tv shows from the repository when execute function is called', () async {
    // arrange
    when(mockTVShowRepository.getPopularTVShows()).thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}
