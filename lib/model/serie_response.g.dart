// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieResponse _$SerieResponseFromJson(Map<String, dynamic> json) =>
    SerieResponse(
      aliases: json['aliases'] as String?,
      apiDetailUrl: json['apiDetailUrl'] as String?,
      characters: json['characters'] as List<dynamic>?,
      episodes: json['episodes'] as List<dynamic>?,
      countOfEpisodes: (json['countOfEpisodes'] as num?)?.toInt(),
      dateAdded: json['dateAdded'] as String?,
      dateLastUpdated: json['dateLastUpdated'] as String?,
      deck: json['deck'] as String?,
      description: json['description'] as String?,
      firstEpisode: json['firstEpisode'] == null
          ? null
          : FirstEpisode.fromJson(json['firstEpisode'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      lastEpisode: json['lastEpisode'] == null
          ? null
          : LastEpisode.fromJson(json['lastEpisode'] as Map<String, dynamic>),
      name: json['name'] as String?,
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      siteDetailUrl: json['siteDetailUrl'] as String?,
      startYear: json['startYear'] as String?,
    );

Map<String, dynamic> _$SerieResponseToJson(SerieResponse instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
      'apiDetailUrl': instance.apiDetailUrl,
      'characters': instance.characters,
      'episodes': instance.episodes,
      'countOfEpisodes': instance.countOfEpisodes,
      'dateAdded': instance.dateAdded,
      'dateLastUpdated': instance.dateLastUpdated,
      'deck': instance.deck,
      'description': instance.description,
      'firstEpisode': instance.firstEpisode,
      'id': instance.id,
      'image': instance.image,
      'lastEpisode': instance.lastEpisode,
      'name': instance.name,
      'publisher': instance.publisher,
      'siteDetailUrl': instance.siteDetailUrl,
      'startYear': instance.startYear,
    };

FirstEpisode _$FirstEpisodeFromJson(Map<String, dynamic> json) => FirstEpisode(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      episodeNumber: json['episodeNumber'] as String?,
    );

Map<String, dynamic> _$FirstEpisodeToJson(FirstEpisode instance) =>
    <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
      'episodeNumber': instance.episodeNumber,
    };

LastEpisode _$LastEpisodeFromJson(Map<String, dynamic> json) => LastEpisode(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      episodeNumber: json['episodeNumber'] as String?,
    );

Map<String, dynamic> _$LastEpisodeToJson(LastEpisode instance) =>
    <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
      'episodeNumber': instance.episodeNumber,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      iconUrl: json['iconUrl'] as String?,
      mediumUrl: json['mediumUrl'] as String?,
      screenUrl: json['screenUrl'] as String?,
      screenLargeUrl: json['screenLargeUrl'] as String?,
      smallUrl: json['smallUrl'] as String?,
      superUrl: json['superUrl'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
      tinyUrl: json['tinyUrl'] as String?,
      originalUrl: json['originalUrl'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'iconUrl': instance.iconUrl,
      'mediumUrl': instance.mediumUrl,
      'screenUrl': instance.screenUrl,
      'screenLargeUrl': instance.screenLargeUrl,
      'smallUrl': instance.smallUrl,
      'superUrl': instance.superUrl,
      'thumbUrl': instance.thumbUrl,
      'tinyUrl': instance.tinyUrl,
      'originalUrl': instance.originalUrl,
    };

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      apiDetailUrl: json['apiDetailUrl'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
      'apiDetailUrl': instance.apiDetailUrl,
      'id': instance.id,
      'name': instance.name,
    };
