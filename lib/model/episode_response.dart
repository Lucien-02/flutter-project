import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode_response.g.dart';

@JsonSerializable()
class EpisodeResponse {
  final String? aliases;
  final String? apiDetailUrl;
  final String? airDate;
  final String? dateAdded;
  final String? dateLastUpdated;
  final String? deck;
  final String? description;
  final HasStaffReview? hasStaffReview;
  final int? id;
  final Image? image;
  final String? episodeNumber;
  final String? name;
  final String? siteDetailUrl;

  EpisodeResponse({
    required this.aliases,
    required this.apiDetailUrl,
    required this.airDate,
    required this.dateAdded,
    required this.dateLastUpdated,
    this.deck,
    required this.description,
    required this.hasStaffReview,
    required this.id,
    required this.image,
    required this.episodeNumber,
    required this.name,
    required this.siteDetailUrl,
  });

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
      aliases: json['aliases'],
      apiDetailUrl: json['api_detail_url'],
      airDate: json['air_date'],
      dateAdded: json['date_added'],
      dateLastUpdated: json['date_last_updated'],
      deck: json['deck'],
      description: json['description'],
      hasStaffReview: json['has_staff_review'] != null
          ? HasStaffReview.fromJson(json['has_staff_review'])
          : null,
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      episodeNumber: json['episode_number'],
      name: json['name'],
      siteDetailUrl: json['site_detail_url'],
    );
  }

  Map<String, dynamic> toJson() => _$EpisodeResponseToJson(this);
}

@JsonSerializable()
class HasStaffReview {
  final String? apiDetailUrl;
  final int? id;
  final String? name;
  final String? siteDetailUrl;

  HasStaffReview({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    required this.siteDetailUrl,
  });

  factory HasStaffReview.fromJson(Map<String, dynamic> json) {
    return HasStaffReview(
      apiDetailUrl: json['api_detail_url'],
      id: json['id'],
      name: json['name'],
      siteDetailUrl: json['site_detail_url'],
    );
  }

  Map<String, dynamic> toJson() => _$HasStaffReviewToJson(this);
}

@JsonSerializable()
class EpisodesListResponse {
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
  final List<EpisodeResponse> results;

  EpisodesListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory EpisodesListResponse.fromJson(Map<String, dynamic> json) {
    return EpisodesListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => EpisodeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}