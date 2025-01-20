import 'package:comics_app/endpoint/api.dart';
import 'package:comics_app/model/comic_response.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:comics_app/model/series_list_response.dart';
import 'package:dio/dio.dart';

import '../model/character_response.dart';
import '../model/episode_response.dart';

class ApiManager {
  static ApiManager? _instance;

  factory ApiManager({
    Dio? dio,
    String? baseUrl,
    String? apiKey,
    String? format,
  }) {
    _instance ??= ApiManager._(
      dio: dio ?? Dio(),
      baseUrl: baseUrl ?? 'https://comicvine.gamespot.com/api/',
    );
    return _instance!;
  }

  final Api api;
  final String apiKey = '16fe65ca9051d1124c729340e506359d647ab1c9';
  final String format = 'json';

  ApiManager._({
    required Dio dio,
    required String baseUrl,
  }) : api = Api(Dio(), baseUrl: 'https://comicvine.gamespot.com/api/') {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers = {
          'api_key': apiKey,
          'format': format,
        };
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }


  Future<SeriesListResponse> loadSerieListFromAPI({
    String? fieldList,
    int? limit,
    int? offset
  }) async {
    return api.loadSeries(
      apiKey: apiKey,
      format: format,
      fieldList: fieldList,
      limit: limit,
      offset: offset,);
  }

  Future<SerieResponseAPI> loadSerieWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;
    print(baseUrl);

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
      },
    );
    return SerieResponseAPI.fromJson(response.data);
  }


  Future<EpisodeResponseAPI> loadEpisodeWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    String? filter,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
        'filter': filter,
      },
    );
    return EpisodeResponseAPI.fromJson(response.data);
  }


  Future<CharacterResponseAPI> loadCharacterWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    String? filter,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
        //'filter': filter,
      },
    );

    return CharacterResponseAPI.fromJson(response.data);
  }

  Future<ComicListResponse> loadComicListFromAPI({
    String? fieldList,
    int? limit,
    int? offset
  }) async {
    return api.loadComics(
      apiKey: apiKey,
      format: format,
      fieldList: fieldList,
      limit: limit,
      offset: offset,);
  }

  Future<ComicResponseAPI> loadComicWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;
    print(baseUrl);

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
      },
    );
    return ComicResponseAPI.fromJson(response.data);
  }

  Future<PersonListResponse> loadPersonListFromAPI({
    String? fieldList,
    int? limit,
    int? offset
  }) async {
    return api.loadPersons(
      apiKey: apiKey,
      format: format,
      fieldList: fieldList,
      limit: limit,
      offset: offset,);
  }

  Future<PersonResponseAPI> loadPersonWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    String? filter,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
        //'filter': filter,
      },
    );
    return PersonResponseAPI.fromJson(response.data);
  }

  Future<FilmListResponse> loadFilmListFromAPI({
    String? fieldList,
    int? limit,
    int? offset
  }) async {
    return api.loadFilms(
      apiKey: apiKey,
      format: format,
      fieldList: fieldList,
      limit: limit,
      offset: offset,);
  }

  Future<FilmResponseAPI> loadFilmWithCustomUrl({
    required String baseUrl,
    String? fieldList,
    int? limit,
  }) async {
    final dio = Dio()
      ..options.baseUrl = baseUrl;

    final response = await dio.get(
      '',
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
      },
    );
    return FilmResponseAPI.fromJson(response.data);
  }
}