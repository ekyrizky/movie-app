import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_shows_event.dart';
part 'watchlist_tv_shows_state.dart';

class WatchlistTVShowsBloc extends Bloc<WatchlistTVShowsEvent, WatchlistTVShowsState> {
  final GetWatchlistTVShows _getWatchlistTVShows;
  final GetWatchListStatusTVShow _getWatchlistStatus;
  final RemoveWatchlistTvShow _removeWatchlist;
  final SaveWatchlistTvShow _saveWatchlist;

  WatchlistTVShowsBloc(
    this._getWatchlistTVShows,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(TVShowWatchlistInitial()) {
    on<FetchTVShowWatchlist>(_fetchTVShowWatchlist);
    on<FetchWatchlistStatus>(_fetchWatchlistStatus);
    on<AddTVShowToWatchlist>(_addTVShowToWatchlist);
    on<RemoveTVShowFromWatchlist>(_removeTVShowFromWatchlist);
  }

  FutureOr<void> _fetchTVShowWatchlist(
    FetchTVShowWatchlist event,
    Emitter<WatchlistTVShowsState> emit,
  ) async {
    emit(TVShowWatchlistLoading());

    final result = await _getWatchlistTVShows.execute();

    result.fold(
      (failure) {
        emit(TVShowWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TVShowWatchlistEmpty()) : emit(TVShowWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistStatus event,
    Emitter<WatchlistTVShowsState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(TVShowIsAddedToWatchlist(result));
  }

  FutureOr<void> _addTVShowToWatchlist(
    AddTVShowToWatchlist event,
    Emitter<WatchlistTVShowsState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _saveWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(TVShowWatchlistError(failure.message));
      },
      (message) {
        emit(TVShowWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _removeTVShowFromWatchlist(
    RemoveTVShowFromWatchlist event,
    Emitter<WatchlistTVShowsState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _removeWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(TVShowWatchlistError(failure.message));
      },
      (message) {
        emit(TVShowWatchlistMessage(message));
      },
    );
  }
}
