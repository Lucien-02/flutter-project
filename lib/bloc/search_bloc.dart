import 'dart:convert';

import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/comic_response.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:comics_app/model/search_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/serie_response.dart';

abstract class SearchEvent {}

class LoadSearchListEvent extends SearchEvent {
  final String? query;
  final String? fieldList;
  LoadSearchListEvent({this.query,this.fieldList});
}

class ResetSearchEvent extends SearchEvent { ResetSearchEvent();}




class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiManager _apiManager;

  SearchBloc (this._apiManager) : super(SearchInitialState()) {

    on<ResetSearchEvent>((event, emit) async {
      emit(SearchInitialState());
    });

    on<LoadSearchListEvent>((event, emit) async {
        //if (state is SearchLoadingState) return;
        try {

          emit(SearchLoadingState());

          await Future.delayed(Duration(seconds: 5));

          final searchResponse = await fetchSearchResults(event.query,event.fieldList);
          final filmResponse = await fetchFilmResults(event.query,event.fieldList);

          emit(SearchLoadedState(series: searchResponse.series,comics: searchResponse.comics,characters: searchResponse.persons,films: filmResponse));

        } catch (error) {
          AppError appError;

          if (error is DioException) {
            appError = AppError.fromDioError(error);
          } else if (error is FormatException) {
            appError = AppError.formatException();
          } else {
            appError = AppError.generic("Une erreur inconnue est survenue.");
          }

          emit(SearchErrorState(message: appError.message, code: appError.code));
        }

    });

  }

  Future<SearchResponse> fetchSearchResults(String? query,String? fieldList) async {

    final response = await _apiManager.loadSearchResultFromAPI(
      fieldList: fieldList,
      query: query,
    );

    if(response.statusCode == 1) {
      return response;
    } else
       throw Exception('Failed to load search results');
  }

  Future<List<FilmResponse>> fetchFilmResults(String? query,String? fieldList) async {

    final response = await _apiManager.loadFilmListFromAPI(
      fieldList: fieldList,
      filter: 'name:$query',
    );

    if(response.statusCode == 1) {
      return response.results;
    } else
      throw Exception('Failed to load search results');
  }
}


sealed class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<SerieResponse> series;
  final List<ComicResponse> comics;
  final List<FilmResponse> films;
  final List<PersonResponse> characters;

  SearchLoadedState({required this.series, required this.comics, required this.films, required this.characters,});
}


class SearchErrorState  extends SearchState {
  final String message;
  final int? code;
  SearchErrorState({required this.message, this.code});
}