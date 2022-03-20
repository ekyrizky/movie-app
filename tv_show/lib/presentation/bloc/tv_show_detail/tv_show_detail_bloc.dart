import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TVShowDetailBloc extends Bloc<TVShowDetailEvent, TVShowDetailState> {
  final GetTVShowDetail _getTVShowDetail;

  TVShowDetailBloc(this._getTVShowDetail) : super(TVShowDetailEmpty()) {
    on<FetchTVShowDetail>(_fetchTVShowDetail);
  }

  FutureOr<void> _fetchTVShowDetail(
    FetchTVShowDetail event,
    Emitter<TVShowDetailState> emit,
  ) async {
    final id = event.id;

    emit(TVShowDetailLoading());

    final result = await _getTVShowDetail.execute(id);

    result.fold(
      (failure) {
        emit(TVShowDetailError(failure.message));
      },
      (data) {
        emit(TVShowDetailHasData(data));
      },
    );
  }
}
