import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(
    this._getNowPlayingMovies,
  ) : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>(_fetchNowPlayingMovies);
  }

  FutureOr<void> _fetchNowPlayingMovies(NowPlayingMoviesEvent event, Emitter<NowPlayingMoviesState> emit) async {
    emit(NowPlayingMoviesLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(NowPlayingMoviesEmpty()) : emit(NowPlayingMoviesHasData(data));
      },
    );
  }
}
