import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'series_list_response.g.dart';

// Represents the whole response from the API
@JsonSerializable()
class SeriesListResponse {
  @JsonKey(name: 'error')
  final String? error;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'offset')
  final int? offset;

  @JsonKey(name: 'number_of_page_results')
  final int? numberOfPageResults;

  @JsonKey(name: 'number_of_total_results')
  final int? numberOfTotalResults;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  @JsonKey(name: 'results')
  final List<SerieResponse> results;

  SeriesListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory SeriesListResponse.fromJson(Map<String, dynamic> json) {
    return SeriesListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => SerieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'limit': limit,
      'offset': offset,
      'number_of_page_results': numberOfPageResults,
      'number_of_total_results': numberOfTotalResults,
      'status_code': statusCode,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class SerieResponseAPI {
  @JsonKey(name: 'error')
  final String? error;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'offset')
  final int? offset;

  @JsonKey(name: 'number_of_page_results')
  final int? numberOfPageResults;

  @JsonKey(name: 'number_of_total_results')
  final int? numberOfTotalResults;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  @JsonKey(name: 'results')
  final SerieResponse results;

  SerieResponseAPI({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory SerieResponseAPI.fromJson(Map<String, dynamic> json) {
    return SerieResponseAPI(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results:  SerieResponse.fromJson(json['results']),
    );
  }



  Map<String, dynamic> toJson() => _$SerieResponseAPIToJson(this);
}
