import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/character_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CharacterEvent {}

class LoadCharacterEvent extends CharacterEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadCharacterEvent({required this.baseUrl,this.fieldList, this.limit});

}



class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ApiManager _apiManager;

  CharacterBloc(this._apiManager) : super(CharacterInitialState()) {

    on<LoadCharacterEvent>((event, emit) async {
      try {
        emit(CharacterLoadingState());

        final character = await _apiManager.loadCharacterWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );

        emit(CharacterLoadedState(character: character.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }
        emit(CharacterErrorState(message: appError.message, code: appError.code));
      }
    });

  }
}


sealed class CharacterState {}

class CharacterInitialState extends CharacterState {}

class CharacterLoadingState extends CharacterState {}

class CharacterLoadedState extends CharacterState {
  final CharacterResponse character;
  CharacterLoadedState({required this.character});
}

class CharacterErrorState  extends CharacterState {
  final String message;
  final int? code;
  CharacterErrorState({required this.message, this.code});
}