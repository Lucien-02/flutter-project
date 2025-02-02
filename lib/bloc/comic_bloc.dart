import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/comic_response.dart';

abstract class ComicEvent {}

class LoadComicListEvent extends ComicEvent {
  final String? fieldList;
  final int? limit;

  LoadComicListEvent({this.fieldList, this.limit});

}

class LoadComicWithCustomUrlEvent extends ComicEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadComicWithCustomUrlEvent({
    required this.baseUrl,
    this.fieldList,
    this.limit,
  });
}

class LoadMoreComicsEvent extends ComicEvent {
  final String? fieldList;

  LoadMoreComicsEvent({this.fieldList});
}


class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final ApiManager _apiManager;
  int offset = 0;
  final int limit = 50;
  List<ComicResponse> comics = [];

  ComicBloc(this._apiManager) : super(ComicInitialState()) {
    on<LoadComicWithCustomUrlEvent>((event, emit) async {
      try {
        // Start loading state
        emit(ComicLoadingState());

        final comicList = await _apiManager.loadComicWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );
        emit(OneComicLoadedState(comic: comicList.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(ComicErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadComicListEvent>((event, emit) async {
      try {
        emit(ComicLoadingState());
        offset = 0;

        final comicList = await _apiManager.loadComicListFromAPI(
          fieldList: event.fieldList,
          limit: event.limit,
        );
        comics = comicList.results;
        emit(ComicLoadedState(comics: comics));
        offset += comicList.results.length;


      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(ComicErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadMoreComicsEvent>((event, emit) async {
      if (state is ComicLoadedState) {
        try {
          List<ComicResponse> currentSeries = [];

          currentSeries = (state as ComicLoadedState).comics;

          final comicList = await _apiManager.loadComicListFromAPI(
            fieldList: event.fieldList,
            limit: limit,
            offset: offset,
          );

          if (comicList.results.isNotEmpty) {
            final updatedComics = [...currentSeries, ...comicList.results];

            offset += comicList.results.length;

            emit(ComicLoadedState(comics: updatedComics));
          } else {
            print('No more data available.');
          }
        } catch (error) {
          print(error);
          AppError appError;

          if (error is DioException) {
            appError = AppError.fromDioError(error);
          } else if (error is FormatException) {
            appError = AppError.formatException();
          } else {
            appError = AppError.generic("Une erreur inconnue est survenue.");
          }

          emit(ComicErrorState(message: appError.message, code: appError.code));
        }
      }
    }
    );
  }
}


sealed class ComicState {}

class ComicInitialState extends ComicState {}

class ComicLoadingState extends ComicState {}

class OneComicLoadedState extends ComicState {
  final ComicResponse comic;
  OneComicLoadedState({required this.comic});
}

class ComicLoadedState extends ComicState {
  final List<ComicResponse> comics;
  ComicLoadedState({required this.comics});
}


class ComicErrorState  extends ComicState {
  final String message;
  final int? code;
  ComicErrorState({required this.message, this.code});
}