import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVShowDetail useCase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    useCase = GetTVShowDetail(mockTVShowRepository);
  });

  final tId = 1;

  test('should get tv show detail from the repository', () async {
    // arrange
    when(mockTVShowRepository.getTVShowDetail(tId)).thenAnswer((_) async => Right(testTVShowDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testTVShowDetail));
  });
}
