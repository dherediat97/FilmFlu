class Pagination<E> {
  final List<E> results;
  final int page;
  final int totalPages;
  final int totalResults;

  Pagination({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  Pagination<E> copyWith({
    List<E>? results,
    int? page,
    int? totalPages,
    int? totalResults,
  }) {
    return Pagination<E>(
      results: results ?? this.results,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}
