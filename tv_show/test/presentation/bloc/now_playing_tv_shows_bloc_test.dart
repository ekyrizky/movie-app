import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingTVShows useCase;
  late NowPlayingTVShowsBloc nowPlayingTVShowsBloc;

  setUp(() {
    useCase = MockGetNowPlayingTVShows();
    nowPlayingTVShowsBloc = NowPlayingTVShowsBloc(useCase);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingTVShowsBloc.state, NowPlayingTVShowsEmpty());
  });

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => Right(testTVShowList));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTVShows()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(useCase.execute());
      return FetchNowPlayingTVShows().props;
    },
  );

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTVShows()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTVShowsLoading(),
  );

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(useCase.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTVShows()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsEmpty(),
    ],
  );
}
