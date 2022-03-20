import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchlistStatus;
  final RemoveWatchlistMovie _removeWatchlist;
  final SaveWatchlistMovie _saveWatchlist;

  WatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(MovieWatchlistInitial()) {
    on<FetchMovieWatchlist>(_fetchMovieWatchlist);
    on<FetchWatchlistStatus>(_fetchWatchlistStatus);
    on<AddMovieToWatchlist>(_addMovieToWatchlist);
    on<RemoveMovieFromWatchlist>(_removeMovieFromWatchlist);
  }

  FutureOr<void> _fetchMovieWatchlist(
    FetchMovieWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(MovieWatchlistLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(MovieWatchlistEmpty()) : emit(MovieWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistStatus event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(MovieIsAddedToWatchlist(result));
  }

  FutureOr<void> _addMovieToWatchlist(
    AddMovieToWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _saveWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (message) {
        emit(MovieWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _removeMovieFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _removeWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (message) {
        emit(MovieWatchlistMessage(message));
      },
    );
  }
}
