import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_response.g.dart';

@JsonSerializable()
class CharacterResponse {
  final String? aliases;
  final String? apiDetailUrl;
  final String? birth;
  final String? deck;
  final String? description;
  final int? countOfIssueAppearances;
  final String? dateAdded;
  final String? dateLastUpdated;
  final FirstAppearedInIssue? firstAppearedInIssue;
  final int? gender;
  final int? id;
  final Image? image;
  final String? name;
  final Origin? origin;
  final Publisher? publisher;
  final String? realName;
  final String? siteDetailUrl;
  final List<dynamic>? creators;

  CharacterResponse({
    required this.aliases,
    required this.apiDetailUrl,
    required this.birth,
    required this.description,
    required this.countOfIssueAppearances,
    required this.dateAdded,
    required this.dateLastUpdated,
    this.deck,
    required this.firstAppearedInIssue,
    required this.gender,
    required this.id,
    required this.image,
    required this.origin,
    required this.name,
    required this.publisher,
    required this.realName,
    required this.siteDetailUrl,
    required this.creators,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      aliases: json['aliases'],
      apiDetailUrl: json['api_detail_url'],
      birth: json['birth'],
      dateAdded: json['date_added'],
      countOfIssueAppearances: json['count_of_issue_appearances'],
      dateLastUpdated: json['date_last_updated'],
      deck: json['deck'],
      gender: json['gender'],
      description: json['description'],
      firstAppearedInIssue: json['first_appeared_in_issue'] != null
          ? FirstAppearedInIssue.fromJson(json['first_appeared_in_issue'])
          : null,
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      origin: json['origin'] != null
          ? Origin.fromJson(json['origin'])
          : null,
      publisher: json['publisher'] != null
          ? Publisher.fromJson(json['publisher'])
          : null,
      realName: json['real_name'],
      name: json['name'],
      siteDetailUrl: json['site_detail_url'],
        creators:json['creators'],
    );
  }

  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);
}

@JsonSerializable()
class FirstAppearedInIssue {
  final String? apiDetailUrl;
  final int? id;
  final String? name;
  final String? issueNumber;

  FirstAppearedInIssue({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    required this.issueNumber,
  });

  factory FirstAppearedInIssue.fromJson(Map<String, dynamic> json) {
    return FirstAppearedInIssue(
      apiDetailUrl: json['api_detail_url'],
      id: json['id'],
      name: json['name'],
      issueNumber: json['issue_number'],
    );
  }

  Map<String, dynamic> toJson() => _$FirstAppearedInIssueToJson(this);
}

@JsonSerializable()
class Origin {
  final String? apiDetailUrl;
  final int? id;
  final String? name;

  Origin({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      apiDetailUrl: json['api_detail_url'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => _$OriginToJson(this);
}

@JsonSerializable()
class CharacterListResponse {
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
  final List<CharacterResponse> results;

  CharacterListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory CharacterListResponse.fromJson(Map<String, dynamic> json) {
    return CharacterListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

@JsonSerializable()
class CharacterResponseAPI {
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
  final CharacterResponse results;

  CharacterResponseAPI({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory CharacterResponseAPI.fromJson(Map<String, dynamic> json) {
    return CharacterResponseAPI(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: CharacterResponse.fromJson(json['results']),
    );
  }
}