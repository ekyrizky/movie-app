import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTVShowsBloc extends Bloc<PopularTVShowsEvent, PopularTVShowsState> {
  final GetPopularTVShows _getPopularTVShows;

  PopularTVShowsBloc(this._getPopularTVShows) : super(PopularTVShowsEmpty()) {
    on<FetchPopularTVShows>(_fetchPopularTVShows);
  }

  FutureOr<void> _fetchPopularTVShows(
    FetchPopularTVShows event,
    Emitter<PopularTVShowsState> emit,
  ) async {
    emit(PopularTVShowsLoading());

    final result = await _getPopularTVShows.execute();

    result.fold(
      (failure) {
        emit(PopularTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(PopularTVShowsEmpty()) : emit(PopularTVShowsHasData(data));
      },
    );
  }
}
