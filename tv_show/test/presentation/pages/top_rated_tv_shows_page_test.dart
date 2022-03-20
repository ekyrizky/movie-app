import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late FakeTopRatedTVShowsBloc fakeTopRatedTVShowsBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTVShowsEvent());
    registerFallbackValue(FakeTopRatedTVShowsState());
    fakeTopRatedTVShowsBloc = FakeTopRatedTVShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVShowsBloc>(
      create: (_) => fakeTopRatedTVShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTopRatedTVShowsBloc.close();
  });

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => fakeTopRatedTVShowsBloc.state).thenReturn(TopRatedTVShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display AppBar when data is loaded', (WidgetTester tester) async {
    when(() => fakeTopRatedTVShowsBloc.state).thenReturn(TopRatedTVShowsHasData(testTVShowList));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVShowsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Top Rated TV Shows'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeTopRatedTVShowsBloc.state).thenReturn(TopRatedTVShowsError(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVShowsPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
