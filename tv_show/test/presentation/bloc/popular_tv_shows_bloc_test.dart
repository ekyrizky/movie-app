import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularTVShows useCase;
  late PopularTVShowsBloc popularTVShowsBloc;

  setUp(() {
    useCase = MockGetPopularTVShows();
    popularTVShowsBloc = PopularTVShowsBloc(useCase);
  });

  test('the initial state should be empty', () {
    expect(popularTVShowsBloc.state, PopularTVShowsEmpty());
  });

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => Right(testTVShowList));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTVShows()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(useCase.execute());
      return FetchPopularTVShows().props;
    },
  );

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTVShows()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsError('Server Failure'),
    ],
    verify: (bloc) => PopularTVShowsLoading(),
  );

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Right([]));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTVShows()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsEmpty(),
    ],
  );
}
