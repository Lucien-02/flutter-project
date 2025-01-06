import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/episode_response.dart';

abstract class EpisodeEvent {}


class LoadEpisodeEvent extends EpisodeEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadEpisodeEvent({
    required this.baseUrl,
    this.fieldList,
    this.limit,
  });
}


class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final ApiManager _apiManager;

  EpisodeBloc(this._apiManager) : super(EpisodeInitialState()) {
    on<LoadEpisodeEvent>((event, emit) async {
      try {
        emit(EpisodeLoadingState());

        final episode = await _apiManager.loadEpisodeWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );

        emit(EpisodeLoadedState(episode: episode.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(EpisodeErrorState(message: appError.message, code: appError.code));
      }
    });

  }
}


sealed class EpisodeState {}

class EpisodeInitialState extends EpisodeState {}

class EpisodeLoadingState extends EpisodeState {}

class EpisodeLoadedState extends EpisodeState {
  final EpisodeResponse episode; // Example for list of series names
  EpisodeLoadedState({required this.episode});
}

class EpisodeErrorState  extends EpisodeState {
  final String message;
  final int? code;
  EpisodeErrorState({required this.message, this.code});
}