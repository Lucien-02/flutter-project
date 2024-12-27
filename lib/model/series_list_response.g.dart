// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesListResponse _$SeriesListResponseFromJson(Map<String, dynamic> json) =>
    SeriesListResponse(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => SerieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesListResponseToJson(SeriesListResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };

SerieResponseAPI _$SerieResponseAPIFromJson(Map<String, dynamic> json) =>
    SerieResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: SerieResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SerieResponseAPIToJson(SerieResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
