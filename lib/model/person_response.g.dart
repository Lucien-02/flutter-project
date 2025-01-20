// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      aliases: json['aliases'] as String?,
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
    };

PersonResponseAPI _$PersonResponseAPIFromJson(Map<String, dynamic> json) =>
    PersonResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: PersonResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonResponseAPIToJson(PersonResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };

PersonListResponse _$PersonListResponseFromJson(Map<String, dynamic> json) =>
    PersonListResponse(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => PersonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonListResponseToJson(PersonListResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
