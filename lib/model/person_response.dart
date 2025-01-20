import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_response.g.dart';

@JsonSerializable()
class PersonResponse {
  final String? aliases;
  final String? apiDetailUrl;
  final int? id;
  final Image? image;
  final String? name;

  PersonResponse({
    required this.aliases,
    required this.apiDetailUrl,
    required this.id,
    required this.image,
    required this.name,
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) {
    return PersonResponse(
      aliases: json['aliases'],
      apiDetailUrl: json['api_detail_url'],
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}


@JsonSerializable()
class PersonResponseAPI {
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
  final PersonResponse results;

  PersonResponseAPI({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory PersonResponseAPI.fromJson(Map<String, dynamic> json) {
    return PersonResponseAPI(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: PersonResponse.fromJson(json['results']),
    );
  }
}

@JsonSerializable()
class PersonListResponse {
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
  final List<PersonResponse> results;

  PersonListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory PersonListResponse.fromJson(Map<String, dynamic> json) {
    return PersonListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PersonResponse.fromJson(e as Map<String, dynamic>))
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

