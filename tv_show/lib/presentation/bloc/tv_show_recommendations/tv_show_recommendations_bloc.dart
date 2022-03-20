import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_recommendations_event.dart';
part 'tv_show_recommendations_state.dart';

class TVShowRecommendationsBloc extends Bloc<TVShowRecommendationsEvent, TVShowRecommendationsState> {
  final GetTVShowRecommendations _getTVShowRecommendations;

  TVShowRecommendationsBloc(this._getTVShowRecommendations) : super(TVShowRecommendationsEmpty()) {
    on<FetchTVShowRecommendations>(_fetchTVShowRecommendations);
  }

  FutureOr<void> _fetchTVShowRecommendations(
    FetchTVShowRecommendations event,
    Emitter<TVShowRecommendationsState> emit,
  ) async {
    final id = event.id;
    emit(TVShowRecommendationsLoading());

    final result = await _getTVShowRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TVShowRecommendationsError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TVShowRecommendationsEmpty()) : emit(TVShowRecommendationsHasData(data));
      },
    );
  }
}
