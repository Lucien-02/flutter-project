import 'package:comics_app/error/app_error.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PersonEvent {}

class LoadPersonEvent extends PersonEvent {
  final String baseUrl;
  final String? fieldList;
  final int? limit;

  LoadPersonEvent({required this.baseUrl,this.fieldList, this.limit});

}



class PersonBloc extends Bloc<LoadPersonEvent, PersonState> {
  final ApiManager _apiManager;

  PersonBloc(this._apiManager) : super(PersonInitialState()) {

    on<LoadPersonEvent>((event, emit) async {
      try {
        emit(PersonLoadingState());

        final person = await _apiManager.loadPersonWithCustomUrl(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
        );

        emit(PersonLoadedState(person: person.results));
      } catch (error) {
        AppError appError;

        if (error is DioException) {
          appError = AppError.fromDioError(error);
        } else if (error is FormatException) {
          appError = AppError.formatException();
        } else {
          print(error);
          appError = AppError.generic("Une erreur inconnue est survenue.");
        }
        emit(PersonErrorState(message: appError.message, code: appError.code));
      }
    });

  }
}


sealed class PersonState {}

class PersonInitialState extends PersonState {}

class PersonLoadingState extends PersonState {}

class PersonLoadedState extends PersonState {
  final PersonResponse person;
  PersonLoadedState({required this.person});
}

class PersonErrorState  extends PersonState {
  final String message;
  final int? code;
  PersonErrorState({required this.message, this.code});
}