import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comic_response.g.dart';

@JsonSerializable()
class ComicResponse {
  final String? aliases;
  final String? apiDetailUrl;
  final List<dynamic>? characterCredits;
  final List<dynamic>? charactersDiedIn;
  final List<dynamic>? personCredits;
  final String? coverDate;
  final String? dateAdded;
  final String? dateLastUpdated;
  final String? deck;
  final String? description;
  final int? id;
  final Image? image;
  final String? issueNumber;
  final String? name;
  final String? storeDate;
  final String? siteDetailUrl;

  ComicResponse({
    required this.aliases,
    required this.apiDetailUrl,
    required this.characterCredits,
    required this.charactersDiedIn,
    required this.personCredits,
    required this.coverDate,
    required this.dateAdded,
    required this.dateLastUpdated,
    this.deck,
    required this.description,
    required this.id,
    required this.image,
    required this.issueNumber,
    required this.name,
    required this.storeDate,
    required this.siteDetailUrl,
  });

  factory ComicResponse.fromJson(Map<String, dynamic> json) {
    return ComicResponse(
      aliases: json['aliases'],
      apiDetailUrl: json['api_detail_url'],
      characterCredits: json['character_credits'],
      charactersDiedIn: json['characters_died_in'],
      personCredits: json['person_credits'],
      coverDate: json['cover_date'],
      dateAdded: json['date_added'],
      dateLastUpdated: json['date_last_updated'],
      deck: json['deck'],
      description: json['description'],
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      issueNumber: json['issue_number'],
      name: json['name'],
      storeDate: json['store_date'],
      siteDetailUrl: json['site_detail_url'],
    );
  }

  Map<String, dynamic> toJson() => _$ComicResponseToJson(this);
}


// Represents the whole response from the API
@JsonSerializable()
class ComicListResponse {
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
  final List<ComicResponse> results;

  ComicListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory ComicListResponse.fromJson(Map<String, dynamic> json) {
    return ComicListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => ComicResponse.fromJson(e as Map<String, dynamic>))
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
class ComicResponseAPI {
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
  final ComicResponse results;

  ComicResponseAPI({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory ComicResponseAPI.fromJson(Map<String, dynamic> json) {
    return ComicResponseAPI(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results:  ComicResponse.fromJson(json['results']),
    );
  }



  Map<String, dynamic> toJson() => _$ComicResponseAPIToJson(this);
}
