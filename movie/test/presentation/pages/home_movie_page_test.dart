import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMovieBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();

    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMovieBloc = FakePopularMoviesBloc();

    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMovieBloc = FakeTopRatedMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview of movies when HasData state occurred', (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesError('error'));
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesError('error'));
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.text("Failed"), findsNWidgets(3));
  });
}
