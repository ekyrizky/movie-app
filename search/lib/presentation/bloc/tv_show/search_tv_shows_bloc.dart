import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_shows_event.dart';
part 'search_tv_shows_state.dart';

class SearchTVShowsBloc extends Bloc<SearchTVShowsEvent, SearchTVShowsState> {
  final SearchTVShows _searchTVShows;

  SearchTVShowsBloc(this._searchTVShows) : super(SearchTVShowsInitial()) {
    on<OnQueryTVShowsChange>(_onQueryTVShowsChange);
  }

  FutureOr<void> _onQueryTVShowsChange(OnQueryTVShowsChange event, Emitter<SearchTVShowsState> emit) async {
    final query = event.query;
    emit(SearchTVShowsEmpty());

    final result = await _searchTVShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(SearchTVShowsEmpty()) : emit(SearchTVShowsHasData(data));
      },
    );
  }

  @override
  Stream<SearchTVShowsState> get stream => super.stream.debounceTime(const Duration(milliseconds: 200));
}
