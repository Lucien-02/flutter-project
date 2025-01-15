// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmResponse _$FilmResponseFromJson(Map<String, dynamic> json) => FilmResponse(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      boxOfficeRevenue: json['boxOfficeRevenue'] as String?,
      budget: json['budget'] as String?,
      characters: json['characters'] as List<dynamic>?,
      studios: json['studios'] as List<dynamic>?,
      producers: json['producers'] as List<dynamic>?,
      writers: json['writers'] as List<dynamic>?,
      dateAdded: json['dateAdded'] as String?,
      dateLastUpdated: json['dateLastUpdated'] as String?,
      deck: json['deck'] as String?,
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      totalRevenue: json['totalRevenue'] as String?,
      name: json['name'] as String?,
      runtime: json['runtime'] as String?,
      releaseDate: json['releaseDate'] as String?,
      rating: json['rating'] as String?,
    );

Map<String, dynamic> _$FilmResponseToJson(FilmResponse instance) =>
    <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'boxOfficeRevenue': instance.boxOfficeRevenue,
      'budget': instance.budget,
      'characters': instance.characters,
      'studios': instance.studios,
      'producers': instance.producers,
      'writers': instance.writers,
      'dateAdded': instance.dateAdded,
      'dateLastUpdated': instance.dateLastUpdated,
      'deck': instance.deck,
      'description': instance.description,
      'id': instance.id,
      'image': instance.image,
      'totalRevenue': instance.totalRevenue,
      'name': instance.name,
      'runtime': instance.runtime,
      'releaseDate': instance.releaseDate,
      'rating': instance.rating,
    };

FilmListResponse _$FilmListResponseFromJson(Map<String, dynamic> json) =>
    FilmListResponse(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => FilmResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilmListResponseToJson(FilmListResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };

FilmResponseAPI _$FilmResponseAPIFromJson(Map<String, dynamic> json) =>
    FilmResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: FilmResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilmResponseAPIToJson(FilmResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
