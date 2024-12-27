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
  });
}
