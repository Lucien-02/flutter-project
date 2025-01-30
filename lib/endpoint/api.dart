import 'package:comics_app/model/comic_response.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:comics_app/model/search_response.dart';
import 'package:comics_app/model/series_list_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {required String baseUrl}) = _Api;

  @GET('series_list/')
  Future<SeriesListResponse> loadSeries({
    @Query('api_key') required String apiKey,
    @Query('format') required String format,
    @Query('field_list') String? fieldList,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('issues/')
  Future<ComicListResponse> loadComics({
    @Query('api_key') required String apiKey,
    @Query('format') required String format,
    @Query('field_list') String? fieldList,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('movies/')
  Future<FilmListResponse> loadFilms({
    @Query('api_key') required String apiKey,
    @Query('format') required String format,
    @Query('field_list') String? fieldList,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('characters/')
  Future<PersonListResponse> loadPersons({
    @Query('api_key') required String apiKey,
    @Query('format') required String format,
    @Query('field_list') String? fieldList,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('search/')
  Future<SearchResponse> loadSearch({
    @Query('api_key') required String apiKey,
    @Query('format') required String format,
    @Query('query') String? query,
    @Query('field_list') String? fieldList,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('resources') String? resources,
  });
}
