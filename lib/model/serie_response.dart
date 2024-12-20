import 'package:json_annotation/json_annotation.dart';

part 'serie_response.g.dart';

@JsonSerializable()
class SerieResponse {
  final String? aliases;
  final String? apiDetailUrl;
  final int? countOfEpisodes;
  final String? dateAdded;
  final String? dateLastUpdated;
  final String? deck;
  final String? description;
  final FirstEpisode? firstEpisode;
  final int? id;
  final Image? image;
  final LastEpisode? lastEpisode;
  final String? name;
  final Publisher? publisher;
  final String? siteDetailUrl;
  final String? startYear;

  SerieResponse({
    required this.aliases,
    required this.apiDetailUrl,
    required this.countOfEpisodes,
    required this.dateAdded,
    required this.dateLastUpdated,
    this.deck,
    required this.description,
    required this.firstEpisode,
    required this.id,
    required this.image,
    required this.lastEpisode,
    required this.name,
    required this.publisher,
    required this.siteDetailUrl,
    required this.startYear,
  });

  factory SerieResponse.fromJson(Map<String, dynamic> json) {
    return SerieResponse(
      aliases: json['aliases'],
      apiDetailUrl: json['api_detail_url'],
      countOfEpisodes: json['count_of_episodes'],
      dateAdded: json['date_added'],
      dateLastUpdated: json['date_last_updated'],
      deck: json['deck'],
      description: json['description'],
      firstEpisode: json['first_episode'] != null
          ? FirstEpisode.fromJson(json['first_episode'])
          : null,
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      lastEpisode: json['last_episode'] != null
          ? LastEpisode.fromJson(json['last_episode'])
          : null,
      name: json['name'],
      publisher: json['publisher'] != null
          ? Publisher.fromJson(json['publisher'])
          : null,
      siteDetailUrl: json['site_detail_url'],
      startYear: json['start_year'],
    );
  }

  Map<String, dynamic> toJson() => _$SerieResponseToJson(this);
}

@JsonSerializable()
class FirstEpisode {
  final String? apiDetailUrl;
  final int? id;
  final String? name;
  final String? episodeNumber;

  FirstEpisode({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    required this.episodeNumber,
  });

  factory FirstEpisode.fromJson(Map<String, dynamic> json) =>
      _$FirstEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$FirstEpisodeToJson(this);
}

@JsonSerializable()
class LastEpisode {
  final String? apiDetailUrl;
  final int? id;
  final String? name;
  final String? episodeNumber;

  LastEpisode({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    required this.episodeNumber,
  });

  factory LastEpisode.fromJson(Map<String, dynamic> json) =>
      _$LastEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToJson(this);
}

@JsonSerializable()
class Image {
  final String? iconUrl;
  final String? mediumUrl;
  final String? screenUrl;
  final String? screenLargeUrl;
  final String? smallUrl;
  final String? superUrl;
  final String? thumbUrl;
  final String? tinyUrl;
  final String? originalUrl;

  Image({
    required this.iconUrl,
    required this.mediumUrl,
    required this.screenUrl,
    required this.screenLargeUrl,
    required this.smallUrl,
    required this.superUrl,
    required this.thumbUrl,
    required this.tinyUrl,
    required this.originalUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      iconUrl: json['icon_url'],
      mediumUrl: json['medium_url'],
      screenUrl: json['screen_url'],
      screenLargeUrl: json['screen_large_url'],
      smallUrl: json['small_url'],
      superUrl: json['super_url'],
      thumbUrl: json['thumb_url'],
      tinyUrl: json['tiny_url'],
      originalUrl: json['original_url'],
    );
  }

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Publisher {
  final String? apiDetailUrl;
  final int? id;
  final String? name;

  Publisher({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}