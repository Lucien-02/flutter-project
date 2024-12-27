// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponse _$CharacterResponseFromJson(Map<String, dynamic> json) =>
    CharacterResponse(
      aliases: json['aliases'] as String?,
      apiDetailUrl: json['apiDetailUrl'] as String?,
      birth: json['birth'] as String?,
      description: json['description'] as String?,
      countOfIssueAppearances:
          (json['countOfIssueAppearances'] as num?)?.toInt(),
      dateAdded: json['dateAdded'] as String?,
      dateLastUpdated: json['dateLastUpdated'] as String?,
      deck: json['deck'] as String?,
      firstAppearedInIssue: json['firstAppearedInIssue'] == null
          ? null
          : FirstAppearedInIssue.fromJson(
              json['firstAppearedInIssue'] as Map<String, dynamic>),
      gender: json['gender'] as String?,
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      origin: json['origin'] == null
          ? null
          : Origin.fromJson(json['origin'] as Map<String, dynamic>),
      name: json['name'] as String?,
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      realName: json['realName'] as String?,
      siteDetailUrl: json['siteDetailUrl'] as String?,
    );

Map<String, dynamic> _$CharacterResponseToJson(CharacterResponse instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
      'apiDetailUrl': instance.apiDetailUrl,
      'birth': instance.birth,
      'deck': instance.deck,
      'description': instance.description,
      'countOfIssueAppearances': instance.countOfIssueAppearances,
      'dateAdded': instance.dateAdded,
      'dateLastUpdated': instance.dateLastUpdated,
      'firstAppearedInIssue': instance.firstAppearedInIssue,
      'gender': instance.gender,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'origin': instance.origin,
      'publisher': instance.publisher,
      'realName': instance.realName,
      'siteDetailUrl': instance.siteDetailUrl,
    };

FirstAppearedInIssue _$FirstAppearedInIssueFromJson(
        Map<String, dynamic> json) =>
    FirstAppearedInIssue(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      issueNumber: json['issueNumber'] as String?,
    );

Map<String, dynamic> _$FirstAppearedInIssueToJson(
        FirstAppearedInIssue instance) =>
    <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
      'issueNumber': instance.issueNumber,
    };

Origin _$OriginFromJson(Map<String, dynamic> json) => Origin(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$OriginToJson(Origin instance) => <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
    };

CharacterListResponse _$CharacterListResponseFromJson(
        Map<String, dynamic> json) =>
    CharacterListResponse(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterListResponseToJson(
        CharacterListResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };

CharacterResponseAPI _$CharacterResponseAPIFromJson(
        Map<String, dynamic> json) =>
    CharacterResponseAPI(
      error: json['error'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      numberOfPageResults: (json['number_of_page_results'] as num?)?.toInt(),
      numberOfTotalResults: (json['number_of_total_results'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      results:
          CharacterResponse.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterResponseAPIToJson(
        CharacterResponseAPI instance) =>
    <String, dynamic>{
      'error': instance.error,
      'limit': instance.limit,
      'offset': instance.offset,
      'number_of_page_results': instance.numberOfPageResults,
      'number_of_total_results': instance.numberOfTotalResults,
      'status_code': instance.statusCode,
      'results': instance.results,
    };
