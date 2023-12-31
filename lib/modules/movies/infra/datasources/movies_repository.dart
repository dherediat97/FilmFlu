import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/entities/pagination.dart';
import 'package:FilmFlu/modules/errors/errors.dart';
import 'package:FilmFlu/modules/movies/domain/entities/movie.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';

class MoviesRepository {
  final ClientHttp _client;

  MoviesRepository(this._client);

  Future<Pagination<Movie>> getMovies({int size = 20, int page = 0}) async {
    try {
      final response = await _client.get(
        url: baseURL + "/trending/movie/day",
      );
      final results = response.data['results'] as List;
      final pagination = Pagination<Movie>(
        results: results.map((e) => Movie.fromJson(e)).toList(),
        page: response.data['page'] ?? 0,
        totalPages: response.data['total_pages'] ?? 0,
        totalResults: response.data['total_results'] ?? 0,
      );
      return pagination;
    } catch (e) {
      throw MovieListException(message: "No se han encontrado películas");
    }
  }
}
