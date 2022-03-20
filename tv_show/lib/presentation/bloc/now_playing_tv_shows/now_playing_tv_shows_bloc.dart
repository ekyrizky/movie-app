import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_shows_event.dart';
part 'now_playing_tv_shows_state.dart';

class NowPlayingTVShowsBloc extends Bloc<NowPlayingTVShowsEvent, NowPlayingTVShowsState> {
  final GetNowPlayingTVShows _getNowPlayingTVShows;

  NowPlayingTVShowsBloc(
    this._getNowPlayingTVShows,
  ) : super(NowPlayingTVShowsEmpty()) {
    on<FetchNowPlayingTVShows>(_fetchNowPlayingTVShows);
  }

  FutureOr<void> _fetchNowPlayingTVShows(NowPlayingTVShowsEvent event, Emitter<NowPlayingTVShowsState> emit) async {
    emit(NowPlayingTVShowsLoading());

    final result = await _getNowPlayingTVShows.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(NowPlayingTVShowsEmpty()) : emit(NowPlayingTVShowsHasData(data));
      },
    );
  }
}
