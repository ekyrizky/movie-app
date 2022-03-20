import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations) : super(MovieRecommendationsEmpty()) {
    on<FetchMovieRecommendations>(_onMovieRecommendationsCalled);
  }

  FutureOr<void> _onMovieRecommendationsCalled(
    FetchMovieRecommendations event,
    Emitter<MovieRecommendationsState> emit,
  ) async {
    final id = event.id;
    emit(MovieRecommendationsLoading());

    final result = await _getMovieRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(MovieRecommendationsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(MovieRecommendationsEmpty()) : emit(MovieRecommendationsHasData(data));
      },
    );
  }
}
