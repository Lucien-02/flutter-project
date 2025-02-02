import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/serie_response.dart';

abstract class SerieEvent {}

class LoadSerieListEvent extends SerieEvent {
  final String? fieldList;
  final int? limit;

  LoadSerieListEvent({this.fieldList, this.limit});

}

class LoadSeriesWithCustomUrlEvent extends SerieEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadSeriesWithCustomUrlEvent({
    required this.baseUrl,
    this.fieldList,
    this.limit,
  });
}

class LoadMoreSeriesEvent extends SerieEvent {
  final String? fieldList;

  LoadMoreSeriesEvent({this.fieldList});
}


class SerieBloc extends Bloc<SerieEvent, SerieState> {
  final ApiManager _apiManager;
  int offset = 0;
  final int limit = 50;
  List<SerieResponse> series = [];

  SerieBloc(this._apiManager) : super(SerieInitialState()) {
    on<LoadSeriesWithCustomUrlEvent>((event, emit) async {
      try {
        // Start loading state
        emit(SerieLoadingState());

        final seriesList = await _apiManager.loadSerieWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );
        emit(OneSerieLoadedState(serie: seriesList.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(SerieErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadSerieListEvent>((event, emit) async {
      try {
        emit(SerieLoadingState());
        offset = 0;

        final seriesList = await _apiManager.loadSerieListFromAPI(
          fieldList: event.fieldList,
          limit: event.limit,
        );
        series = seriesList.results;
        emit(SerieLoadedState(series: series));
        offset += seriesList.results.length;


      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }

        emit(SerieErrorState(message: appError.message, code: appError.code));
      }
    });

    on<LoadMoreSeriesEvent>((event, emit) async {
      if (state is SerieLoadedState) {
        try {
          List<SerieResponse> currentSeries = [];

          currentSeries = (state as SerieLoadedState).series;

          final seriesList = await _apiManager.loadSerieListFromAPI(
            fieldList: event.fieldList,
            limit: limit,
            offset: offset,
          );

          if (seriesList.results.isNotEmpty) {
            final updatedSeries = [...currentSeries, ...seriesList.results];

            offset += seriesList.results.length;

            emit(SerieLoadedState(series: updatedSeries));
          } else {
            print('No more data available.');
          }
        } catch (error) {
          AppError appError;

          if (error is DioException) {
            appError = AppError.fromDioError(error);
          } else if (error is FormatException) {
            appError = AppError.formatException();
          } else {
            appError = AppError.generic("Une erreur inconnue est survenue.");
          }

          emit(SerieErrorState(message: appError.message, code: appError.code));
        }
      }
    }
    );
  }
}


sealed class SerieState {}

class SerieInitialState extends SerieState {}

class SerieLoadingState extends SerieState {}

class OneSerieLoadedState extends SerieState {
  final SerieResponse serie;
  OneSerieLoadedState({required this.serie});
}

class SerieLoadedState extends SerieState {
  final List<SerieResponse> series;
  SerieLoadedState({required this.series});
}


class SerieErrorState  extends SerieState {
  final String message;
  final int? code;
  SerieErrorState({required this.message, this.code});
}