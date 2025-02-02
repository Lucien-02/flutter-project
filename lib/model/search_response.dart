

import 'package:comics_app/model/character_response.dart';
import 'package:comics_app/model/comic_response.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:comics_app/model/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

class SearchResponse {
  final List<SerieResponse> series;
  final List<PersonResponse> persons;
  final List<ComicResponse> comics;

  final String? error;
  final int? limit;
  final int? offset;
  final int? numberOfPageResults;
  final int? numberOfTotalResults;
  final int? statusCode;


  SearchResponse({
    required this.series,
    required this.persons,
    required this.comics,
    required this.numberOfTotalResults,
    required this.statusCode,
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {

    List<dynamic> results = json['results'] ?? [];
    List<SerieResponse> series = [];
    List<ComicResponse> comics = [];
    List<FilmResponse> films = [];
    List<PersonResponse> persons = [];

    for (var item in results) {
      switch (item['resource_type']) {
        case 'series':
          series.add(SerieResponse.fromJson(item));
          break;
        case 'character':
          persons.add(PersonResponse.fromJson(item));
          break;
        case 'issue':
          comics.add(ComicResponse.fromJson(item));
          break;
      }
    }
    return SearchResponse(
      error: json['error'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      numberOfPageResults: json['number_of_page_results'] as int?,
      numberOfTotalResults: json['number_of_total_results'] as int?,
      statusCode: json['status_code'] as int?,
      series: series,
      persons: persons,
      comics: comics,
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
      'series' : series,
      'persons' : persons,
      'comics' : comics,
    };
  }
}