import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/comic_response.dart';

abstract class FilmEvent {}

class LoadFilmListEvent extends FilmEvent {
  final String? fieldList;
  final int? limit;

  LoadFilmListEvent({this.fieldList, this.limit});

}

class LoadFilmWithCustomUrlEvent extends FilmEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadFilmWithCustomUrlEvent({
    required this.baseUrl,
    this.fieldList,
    this.limit,
  });
}

class LoadMoreFilmsEvent extends FilmEvent {
  final String? fieldList;

  LoadMoreFilmsEvent({this.fieldList});
}


class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final ApiManager _apiManager;
  int offset = 0;
  final int limit = 50;
  List<FilmResponse> films = [];

  FilmBloc(this._apiManager) : super(FilmInitialState()) {
    on<LoadFilmWithCustomUrlEvent>((event, emit) async {
      try {
        // Start loading state
        emit(FilmLoadingState());

        final filmList = await _apiManager.loadFilmWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );
        emit(OneFilmLoadedState(film: filmList.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(FilmErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadFilmListEvent>((event, emit) async {
      try {
        emit(FilmLoadingState());
        offset = 0;

        final filmList = await _apiManager.loadFilmListFromAPI(
          fieldList: event.fieldList,
          limit: event.limit,
        );
        films = filmList.results;
        emit(FilmLoadedState(films: films));
        offset += filmList.results.length;


      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(FilmErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadMoreFilmsEvent>((event, emit) async {
      if (state is FilmLoadedState) {
        try {
          List<FilmResponse> currentSeries = [];

          currentSeries = (state as FilmLoadedState).films;

          final filmList = await _apiManager.loadFilmListFromAPI(
            fieldList: event.fieldList,
            limit: limit,
            offset: offset,
          );

          if (filmList.results.isNotEmpty) {
            final updatedFilms = [...currentSeries, ...filmList.results];

            offset += filmList.results.length;

            emit(FilmLoadedState(films: updatedFilms));
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

          emit(FilmErrorState(message: appError.message, code: appError.code));
        }
      }
    }
    );
  }
}


sealed class FilmState {}

class FilmInitialState extends FilmState {}

class FilmLoadingState extends FilmState {}

class OneFilmLoadedState extends FilmState {
  final FilmResponse film;
  OneFilmLoadedState({required this.film});
}

class FilmLoadedState extends FilmState {
  final List<FilmResponse> films;
  FilmLoadedState({required this.films});
}


class FilmErrorState  extends FilmState {
  final String message;
  final int? code;
  FilmErrorState({required this.message, this.code});
}