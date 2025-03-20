enum SortOptions {
  popularity(name: 'popularity'),
  mediaName(name: 'name'),
  movieDate(name: 'primary_release_date'),
  tvSeriesDate(name: 'first_air_date'),
  voteCount(name: 'vote_count'),
  voteAverage(name: 'vote_average');

  const SortOptions({required this.name});

  final String name;
}
