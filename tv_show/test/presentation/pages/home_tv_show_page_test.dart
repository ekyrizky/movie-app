import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late FakeNowPlayingTVShowsBloc fakeNowPlayingTVShowsBloc;
  late FakePopularTVShowsBloc fakePopularTVShowBloc;
  late FakeTopRatedTVShowsBloc fakeTopRatedTVShowBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingTVShowsEvent());
    registerFallbackValue(FakeNowPlayingTVShowsState());
    fakeNowPlayingTVShowsBloc = FakeNowPlayingTVShowsBloc();

    registerFallbackValue(FakePopularTVShowsEvent());
    registerFallbackValue(FakePopularTVShowsState());
    fakePopularTVShowBloc = FakePopularTVShowsBloc();

    registerFallbackValue(FakeTopRatedTVShowsEvent());
    registerFallbackValue(FakeTopRatedTVShowsState());
    fakeTopRatedTVShowBloc = FakeTopRatedTVShowsBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingTVShowsBloc.close();
    fakePopularTVShowBloc.close();
    fakeTopRatedTVShowBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTVShowsBloc>(
          create: (context) => fakeNowPlayingTVShowsBloc,
        ),
        BlocProvider<PopularTVShowsBloc>(
          create: (context) => fakePopularTVShowBloc,
        ),
        BlocProvider<TopRatedTVShowsBloc>(
          create: (context) => fakeTopRatedTVShowBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state).thenReturn(NowPlayingTVShowsLoading());
    when(() => fakePopularTVShowBloc.state).thenReturn(PopularTVShowsLoading());
    when(() => fakeTopRatedTVShowBloc.state).thenReturn(TopRatedTVShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(HomeTVShowPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview of tv shows when HasData state occurred', (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state).thenReturn(NowPlayingTVShowsHasData(testTVShowList));
    when(() => fakePopularTVShowBloc.state).thenReturn(PopularTVShowsHasData(testTVShowList));
    when(() => fakeTopRatedTVShowBloc.state).thenReturn(TopRatedTVShowsHasData(testTVShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(HomeTVShowPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state).thenReturn(NowPlayingTVShowsError('error'));
    when(() => fakePopularTVShowBloc.state).thenReturn(PopularTVShowsError('error'));
    when(() => fakeTopRatedTVShowBloc.state).thenReturn(TopRatedTVShowsError('error'));

    await tester.pumpWidget(_createTestableWidget(HomeTVShowPage()));

    expect(find.text("Failed"), findsNWidgets(3));
  });
}
