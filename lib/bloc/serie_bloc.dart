import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/serie_response.dart';
import '../endpoint/api.dart';

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


class SerieBloc extends Bloc<SerieEvent, SerieState> {
  final ApiManager _apiManager;

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
        print(seriesList);
        // After fetching data, emit the loaded state
        emit(OneSerieLoadedState(serie: seriesList.results));
      } catch (error) {
        emit(SerieErrorState(error));
      }
    });

    on<LoadSerieListEvent>((event, emit) async {
      try {
        // Start loading state
        emit(SerieLoadingState());

        final seriesList = await _apiManager.loadSerieListFromAPI(
          fieldList: event.fieldList,
          limit: event.limit,
        );
        // After fetching data, emit the loaded state
        emit(SerieLoadedState(series: seriesList.results)); // Example data
      } catch (error) {
        emit(SerieErrorState(error));
      }
    });
   // add(LoadSerieListEvent());

  }
}


sealed class SerieState {}

class SerieInitialState extends SerieState {}

class SerieLoadingState extends SerieState {}

class OneSerieLoadedState extends SerieState {
  final SerieResponse serie; // Example for list of series names
  OneSerieLoadedState({required this.serie});
}

class SerieLoadedState extends SerieState {
  final List<SerieResponse> series; // Example for list of series names
  SerieLoadedState({required this.series});
}

class SerieErrorState  extends SerieState {
  final dynamic error;
  SerieErrorState(this.error);
}