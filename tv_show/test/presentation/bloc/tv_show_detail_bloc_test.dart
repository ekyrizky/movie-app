import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTVShowDetail useCase;
  late TVShowDetailBloc tvShowDetailBloc;

  const testId = 1;

  setUp(() {
    useCase = MockGetTVShowDetail();
    tvShowDetailBloc = TVShowDetailBloc(useCase);
  });

  test('the initial state should be empty', () {
    expect(tvShowDetailBloc.state, TVShowDetailEmpty());
  });

  blocTest<TVShowDetailBloc, TVShowDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(useCase.execute(testId)).thenAnswer((_) async => Right(testTVShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTVShowDetail(testId)),
    expect: () => [
      TVShowDetailLoading(),
      TVShowDetailHasData(testTVShowDetail),
    ],
    verify: (bloc) {
      verify(useCase.execute(testId));
      return FetchTVShowDetail(testId).props;
    },
  );

  blocTest<TVShowDetailBloc, TVShowDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(useCase.execute(testId)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTVShowDetail(testId)),
    expect: () => [
      TVShowDetailLoading(),
      TVShowDetailError('Server Failure'),
    ],
    verify: (bloc) => TVShowDetailLoading(),
  );
}
