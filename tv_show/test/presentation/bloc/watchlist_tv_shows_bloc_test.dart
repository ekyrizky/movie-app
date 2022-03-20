import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWatchlistTVShows getWatchlistTVShows;
  late MockGetWatchListStatusTVShow getWatchlistStatus;
  late MockRemoveWatchlistTvShow removeWatchlist;
  late MockSaveWatchlistTvShow saveWatchlist;
  late WatchlistTVShowsBloc watchlistTVShowsBloc;

  setUp(() {
    getWatchlistTVShows = MockGetWatchlistTVShows();
    getWatchlistStatus = MockGetWatchListStatusTVShow();
    removeWatchlist = MockRemoveWatchlistTvShow();
    saveWatchlist = MockSaveWatchlistTvShow();
    watchlistTVShowsBloc = WatchlistTVShowsBloc(
      getWatchlistTVShows,
      getWatchlistStatus,
      removeWatchlist,
      saveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchlistTVShowsBloc.state, TVShowWatchlistInitial());
  });

  group(
    'get watchlist tv shows test cases',
    () {
      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(getWatchlistTVShows.execute()).thenAnswer((_) async => Right(testWatchlistTVShow));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(FetchTVShowWatchlist()),
        expect: () => [
          TVShowWatchlistLoading(),
          TVShowWatchlistHasData(testWatchlistTVShow),
        ],
        verify: (bloc) {
          verify(getWatchlistTVShows.execute());
          return FetchTVShowWatchlist().props;
        },
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(getWatchlistTVShows.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(FetchTVShowWatchlist()),
        expect: () => [
          TVShowWatchlistLoading(),
          TVShowWatchlistError('Server Failure'),
        ],
        verify: (bloc) => TVShowWatchlistLoading(),
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(getWatchlistTVShows.execute()).thenAnswer((_) async => const Right([]));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(FetchTVShowWatchlist()),
        expect: () => [
          TVShowWatchlistLoading(),
          TVShowWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(getWatchlistStatus.execute(testTVShowDetail.id)).thenAnswer((_) async => true);
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testTVShowDetail.id)),
        expect: () => [
          TVShowIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testTVShowDetail.id));
          return FetchWatchlistStatus(testTVShowDetail.id).props;
        },
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(getWatchlistStatus.execute(testTVShowDetail.id)).thenAnswer((_) async => false);
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testTVShowDetail.id)),
        expect: () => [
          TVShowIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testTVShowDetail.id));
          return FetchWatchlistStatus(testTVShowDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(saveWatchlist.execute(testTVShowDetail)).thenAnswer((_) async => const Right(watchlistAddMessage));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(AddTVShowToWatchlist(testTVShowDetail)),
        expect: () => [
          TVShowWatchlistMessage(watchlistAddMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testTVShowDetail));
          return AddTVShowToWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(saveWatchlist.execute(testTVShowDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(AddTVShowToWatchlist(testTVShowDetail)),
        expect: () => [
          TVShowWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testTVShowDetail));
          return AddTVShowToWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(removeWatchlist.execute(testTVShowDetail)).thenAnswer((_) async => const Right(watchlistRemoveMessage));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(RemoveTVShowFromWatchlist(testTVShowDetail)),
        expect: () => [
          TVShowWatchlistMessage(watchlistRemoveMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testTVShowDetail));
          return RemoveTVShowFromWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(removeWatchlist.execute(testTVShowDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTVShowsBloc;
        },
        act: (bloc) => bloc.add(RemoveTVShowFromWatchlist(testTVShowDetail)),
        expect: () => [
          TVShowWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testTVShowDetail));
          return RemoveTVShowFromWatchlist(testTVShowDetail).props;
        },
      );
    },
  );
}
