import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTVShowsBloc extends Bloc<TopRatedTVShowsEvent, TopRatedTVShowsState> {
  final GetTopRatedTVShows _getTopRatedTVShows;

  TopRatedTVShowsBloc(this._getTopRatedTVShows) : super(TopRatedTVShowsEmpty()) {
    on<FetchTopRatedTVShows>(_fetchTopRatedTVShows);
  }

  FutureOr<void> _fetchTopRatedTVShows(
    FetchTopRatedTVShows event,
    Emitter<TopRatedTVShowsState> emit,
  ) async {
    emit(TopRatedTVShowsLoading());

    final result = await _getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        emit(TopRatedTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TopRatedTVShowsEmpty()) : emit(TopRatedTVShowsHasData(data));
      },
    );
  }
}
