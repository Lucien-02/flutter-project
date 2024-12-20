import 'package:comics_app/endpoint/api.dart';
import 'package:comics_app/model/serie_response.dart';
import 'package:comics_app/model/series_list_response.dart';
import 'package:dio/dio.dart';

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
          'api_key': apiKey,  // Add api_key header
          'format': format,  // Add format header
        };
        return handler.next(options);  // Continue with the request
      },
      onResponse: (response, handler) {
        return handler.next(response);  // Continue with the response
      },
      onError: (DioError e, handler) {
        return handler.next(e);  // Continue with the error
      },
    ));
  }


  Future<SeriesListResponse> loadSerieListFromAPI({
    String? fieldList,
    int? limit,
  }) async {
      return api.loadSeries(
        apiKey: apiKey,
        format: format,
        fieldList: fieldList,
        limit: limit,);
    }

  Future<SerieResponseAPI> loadSerieWithCustomUrl({
    required String baseUrl, // Full URL including the base
    String? fieldList,
    int? limit,
  }) async {
    final dio = Dio()..options.baseUrl = baseUrl;
    print(baseUrl);

    final response = await dio.get(
      '', // Leave endpoint blank because you're only targeting the base URL
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
      },
    );
    // Deserialize the response
    return SerieResponseAPI.fromJson(response.data);
  }


  Future<EpisodesListResponse> loadEpisodesBySerie({
    required String baseUrl, // Full URL including the base
    String? fieldList,
    String? filter,
    int? limit,
  }) async {
    final dio = Dio()..options.baseUrl = baseUrl;
    print(baseUrl);

    final response = await dio.get(
      '', // Leave endpoint blank because you're only targeting the base URL
      queryParameters: {
        'api_key': apiKey,
        'format': format,
        'field_list': fieldList,
        'limit': limit,
        'filter': filter,
      },
    );
    // Deserialize the response
    return EpisodesListResponse.fromJson(response.data);
  }
}