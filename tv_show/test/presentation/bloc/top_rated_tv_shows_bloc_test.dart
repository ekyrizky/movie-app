import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTVShows useCase;
  late TopRatedTVShowsBloc topRatedTVShowsBloc;

  setUp(() {
    useCase = MockGetTopRatedTVShows();
    topRatedTVShowsBloc = TopRatedTVShowsBloc(useCase);
  });

  test('the initial state should be empty', () {
    expect(topRatedTVShowsBloc.state, TopRatedTVShowsEmpty());
  });

  blocTest<TopRatedTVShowsBloc, TopRatedTVShowsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => Right(testTVShowList));
      return topRatedTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVShows()),
    expect: () => [
      TopRatedTVShowsLoading(),
      TopRatedTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(useCase.execute());
      return FetchTopRatedTVShows().props;
    },
  );

  blocTest<TopRatedTVShowsBloc, TopRatedTVShowsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVShows()),
    expect: () => [
      TopRatedTVShowsLoading(),
      TopRatedTVShowsError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTVShowsLoading(),
  );

  blocTest<TopRatedTVShowsBloc, TopRatedTVShowsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Right([]));
      return topRatedTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVShows()),
    expect: () => [
      TopRatedTVShowsLoading(),
      TopRatedTVShowsEmpty(),
    ],
  );
}
