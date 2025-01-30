class SearchResponse {
  final String error;
  final int limit;
  final int offset;
  final int numberOfPageResults;
  final int numberOfTotalResults;
  final List<SearchResult> results;

  SearchResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.numberOfPageResults,
    required this.numberOfTotalResults,
    required this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<SearchResult> resultList =
        list.map((i) => SearchResult.fromJson(i)).toList();

    return SearchResponse(
      error: json['error'],
      limit: json['limit'],
      offset: json['offset'],
      numberOfPageResults: json['number_of_page_results'],
      numberOfTotalResults: json['number_of_total_results'],
      results: resultList,
    );
  }
}

class SearchResult {
  final String name;
  final String resourceType;

  SearchResult({required this.name, required this.resourceType});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      name: json['name'],
      resourceType: json['resource_type'],
    );
  }
}
