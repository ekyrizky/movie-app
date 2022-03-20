import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

/// fake search movies bloc
class FakeSearchMoviesEvent extends Fake implements SearchMoviesEvent {}

class FakeSearchMoviesState extends Fake implements SearchMoviesState {}

class FakeSearchMoviesBloc extends MockBloc<SearchMoviesEvent, SearchMoviesState> implements SearchMoviesBloc {}

/// fake search tv shows bloc
class FakeSearchTVShowsEvent extends Fake implements SearchTVShowsEvent {}

class FakeSearchTVShowsState extends Fake implements SearchTVShowsState {}

class FakeSearchTVShowsBloc extends MockBloc<SearchTVShowsEvent, SearchTVShowsState> implements SearchTVShowsBloc {}
