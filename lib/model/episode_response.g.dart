// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeResponse _$EpisodeResponseFromJson(Map<String, dynamic> json) =>
    EpisodeResponse(
      aliases: json['aliases'] as String?,
      apiDetailUrl: json['apiDetailUrl'] as String?,
      airDate: json['airDate'] as String?,
      dateAdded: json['dateAdded'] as String?,
      dateLastUpdated: json['dateLastUpdated'] as String?,
      deck: json['deck'] as String?,
      description: json['description'] as String?,
      hasStaffReview: json['hasStaffReview'] == null
          ? null
          : HasStaffReview.fromJson(
              json['hasStaffReview'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      episodeNumber: json['episodeNumber'] as String?,
      name: json['name'] as String?,
      siteDetailUrl: json['siteDetailUrl'] as String?,
    );

Map<String, dynamic> _$EpisodeResponseToJson(EpisodeResponse instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
      'apiDetailUrl': instance.apiDetailUrl,
      'airDate': instance.airDate,
      'dateAdded': instance.dateAdded,
      'dateLastUpdated': instance.dateLastUpdated,
      'deck': instance.deck,
      'description': instance.description,
      'hasStaffReview': instance.hasStaffReview,
      'id': instance.id,
      'image': instance.image,
      'episodeNumber': instance.episodeNumber,
      'name': instance.name,
      'siteDetailUrl': instance.siteDetailUrl,
    };

HasStaffReview _$HasStaffReviewFromJson(Map<String, dynamic> json) =>
    HasStaffReview(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      siteDetailUrl: json['siteDetailUrl'] as String?,
    );

Map<String, dynamic> _$HasStaffReviewToJson(HasStaffReview instance) =>
    <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
      'siteDetailUrl': instance.siteDetailUrl,
    };

EpisodeResponseAPI _$EpisodeResponseAPIFromJson(Map<String, dynamic> json) =>
    EpisodeResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results:
          EpisodeResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EpisodeResponseAPIToJson(EpisodeResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
