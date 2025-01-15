import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'film_response.g.dart';

@JsonSerializable()
class FilmResponse {
  final String? apiDetailUrl;
  final String? boxOfficeRevenue;
  final String? budget;
  final List<dynamic>? characters;
  final List<dynamic>? studios;
  final List<dynamic>? producers;
  final List<dynamic>? writers;
  final String? dateAdded;
  final String? dateLastUpdated;
  final String? deck;
  final String? description;
  final int? id;
  final Image? image;
  final String? totalRevenue;
  final String? name;
  final String? runtime;
  final String? releaseDate;
  final String? rating;

  FilmResponse({
    required this.apiDetailUrl,
    required this.boxOfficeRevenue,
    required this.budget,
    required this.characters,
    required this.studios,
    required this.producers,
    required this.writers,
    required this.dateAdded,
    required this.dateLastUpdated,
    this.deck,
    required this.description,
    required this.id,
    required this.image,
    required this.totalRevenue,
    required this.name,
    required this.runtime,
    required this.releaseDate,
    required this.rating,
  });

  factory FilmResponse.fromJson(Map<String, dynamic> json) {
    return FilmResponse(
      apiDetailUrl: json['api_detail_url'],
      boxOfficeRevenue: json['box_office_revenue'],
      budget: json['budget'],
      characters: json['characters'],
      producers: json['producers'],
      studios: json['studios'],
      writers: json['writers'],
      dateAdded: json['date_added'],
      dateLastUpdated: json['date_last_updated'],
      deck: json['deck'],
      description: json['description'],
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      totalRevenue: json['total_revenue'],
      name: json['name'],
      runtime: json['runtime'],
      releaseDate: json['releaseDate'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => _$FilmResponseToJson(this);
}


// Represents the whole response from the API
@JsonSerializable()
class FilmListResponse {
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
  final List<FilmResponse> results;

  FilmListResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory FilmListResponse.fromJson(Map<String, dynamic> json) {
    return FilmListResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results: (json['results'] as List<dynamic>)
          .map((e) => FilmResponse.fromJson(e as Map<String, dynamic>))
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
class FilmResponseAPI {
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
  final FilmResponse results;

  FilmResponseAPI({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.results,
  });

  factory FilmResponseAPI.fromJson(Map<String, dynamic> json) {
    return FilmResponseAPI(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      results:  FilmResponse.fromJson(json['results']),
    );
  }



  Map<String, dynamic> toJson() => _$FilmResponseAPIToJson(this);
}
