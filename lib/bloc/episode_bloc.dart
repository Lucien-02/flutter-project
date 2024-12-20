import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/episode_response.dart';
import '../endpoint/api.dart';

abstract class EpisodeEvent {}

class LoadEpisodeListEvent extends EpisodeEvent {
  final String? fieldList;
  final int? limit;

  LoadEpisodeListEvent({this.fieldList, this.limit});

}

class LoadEpisodeBySerieEvent extends EpisodeEvent {
  final String baseUrl;
  final String filter;
  final String? fieldList;
  final int? limit;

  LoadEpisodeBySerieEvent({
    required this.baseUrl,
    required this.filter,
    this.fieldList,
    this.limit,
  });
}


class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final ApiManager _apiManager;

  EpisodeBloc(this._apiManager) : super(EpisodeInitialState()) {
    on<LoadEpisodeBySerieEvent>((event, emit) async {
      try {
        // Start loading state
        emit(EpisodeLoadingState());

        final episodesList = await _apiManager.loadEpisodesBySerie(
          baseUrl: event.baseUrl,
          fieldList: event.fieldList,
          limit: event.limit,
          filter: event.filter,
        );
        print(episodesList);
        // After fetching data, emit the loaded state
        emit(EpisodeLoadedState(episodes: episodesList.results));
      } catch (error) {
        emit(EpisodeErrorState(error));
      }
    });

  }
}


sealed class EpisodeState {}

class EpisodeInitialState extends EpisodeState {}

class EpisodeLoadingState extends EpisodeState {}

class EpisodeLoadedState extends EpisodeState {
  final List<EpisodeResponse> episodes; // Example for list of series names
  EpisodeLoadedState({required this.episodes});
}

class EpisodeErrorState  extends EpisodeState {
  final dynamic error;
  EpisodeErrorState(this.error);
}