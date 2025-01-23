// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicResponse _$ComicResponseFromJson(Map<String, dynamic> json) =>
    ComicResponse(
      aliases: json['aliases'] as String?,
      apiDetailUrl: json['apiDetailUrl'] as String?,
      characterCredits: json['characterCredits'] as List<dynamic>?,
      charactersDiedIn: json['charactersDiedIn'] as List<dynamic>?,
      personCredits: json['personCredits'] as List<dynamic>?,
      coverDate: json['coverDate'] as String?,
      dateAdded: json['dateAdded'] as String?,
      dateLastUpdated: json['dateLastUpdated'] as String?,
      deck: json['deck'] as String?,
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      issueNumber: json['issueNumber'] as String?,
      name: json['name'] as String?,
      storeDate: json['storeDate'] as String?,
      siteDetailUrl: json['siteDetailUrl'] as String?,
      volume: json['volume'] == null
          ? null
          : Volume.fromJson(json['volume'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicResponseToJson(ComicResponse instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
      'apiDetailUrl': instance.apiDetailUrl,
      'characterCredits': instance.characterCredits,
      'charactersDiedIn': instance.charactersDiedIn,
      'personCredits': instance.personCredits,
      'coverDate': instance.coverDate,
      'dateAdded': instance.dateAdded,
      'dateLastUpdated': instance.dateLastUpdated,
      'deck': instance.deck,
      'description': instance.description,
      'id': instance.id,
      'image': instance.image,
      'issueNumber': instance.issueNumber,
      'name': instance.name,
      'storeDate': instance.storeDate,
      'siteDetailUrl': instance.siteDetailUrl,
      'volume': instance.volume,
    };

Volume _$VolumeFromJson(Map<String, dynamic> json) => Volume(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$VolumeToJson(Volume instance) => <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
    };

ComicListResponse _$ComicListResponseFromJson(Map<String, dynamic> json) =>
    ComicListResponse(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => ComicResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicListResponseToJson(ComicListResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };

ComicResponseAPI _$ComicResponseAPIFromJson(Map<String, dynamic> json) =>
    ComicResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: ComicResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicResponseAPIToJson(ComicResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
