import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../dummy_object/dummy_objects.dart';
import '../../helpers/page_test_helper.dart';

void main() {
  late FakeSearchMoviesBloc fakeSearchMoviesBloc;
  late FakeSearchTVShowsBloc fakeSearchTVShowsBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
    fakeSearchMoviesBloc = FakeSearchMoviesBloc();

    registerFallbackValue(FakeSearchTVShowsEvent());
    registerFallbackValue(FakeSearchTVShowsState());
    fakeSearchTVShowsBloc = FakeSearchTVShowsBloc();
  });

  tearDown(() {
    fakeSearchMoviesBloc.close();
    fakeSearchTVShowsBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMoviesBloc>(
          create: (context) => fakeSearchMoviesBloc,
        ),
        BlocProvider<SearchTVShowsBloc>(
          create: (context) => fakeSearchTVShowsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search movies test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMoviesLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.Movie,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when successful",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMoviesHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.Movie,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMoviesError('error'));

        final emptyMessageWidget = find.byType(EmptyMessage);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.Movie,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyMessageWidget, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMoviesEmpty());

        final emptyMessageWidget = find.byType(EmptyMessage);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.Movie,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyMessageWidget, findsOneWidget);
        expect(find.text(emptySearch), findsOneWidget);
      },
    );
  });

  group('search tv shows test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTVShowsLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.TVShow,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTVShowsHasData(testTVShowList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.TVShow,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTVShowsError('error'));

        final emptyMessageWidget = find.byType(EmptyMessage);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.TVShow,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyMessageWidget, findsOneWidget);
        expect(find.text(emptySearch), findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTVShowsEmpty());

        final emptyMessageWidget = find.byType(EmptyMessage);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.TVShow,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyMessageWidget, findsOneWidget);
      },
    );
  });
}
