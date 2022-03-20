import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>(
      create: (_) => fakeWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeWatchlistMoviesBloc.close();
  });

  group('watchlist movies', () {
    testWidgets('loading indicator should display when getting data', (WidgetTester tester) async {
      when(() => fakeWatchlistMoviesBloc.state).thenReturn(MovieWatchlistLoading());

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('watchlist movies should display', (WidgetTester tester) async {
      when(() => fakeWatchlistMoviesBloc.state).thenReturn(MovieWatchlistHasData(testMovieList));

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(CardList), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty', (WidgetTester tester) async {
      when(() => fakeWatchlistMoviesBloc.state).thenReturn(MovieWatchlistEmpty());

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(EmptyMessage), findsOneWidget);
      expect(find.text(emptyWatchlist), findsOneWidget);
    });
  });
}
