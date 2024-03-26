import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/entities/pagination.dart';
import 'package:FilmFlu/modules/errors/errors.dart';
import 'package:FilmFlu/modules/movies/domain/entities/movie.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';

abstract class MoviesRepository {
  Future<Pagination<Movie>> getMovies();
}

class HttpMoviesRepository implements MoviesRepository {
  HttpMoviesRepository({required this.client});

  final ClientHttp client;

  Future<Pagination<Movie>> getMovies(
      {int size = 20, int page = 0, String mediaType = ""}) async {
    try {
      final response = await client.get(
        url: baseURL + "/trending/${mediaType}/day",
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
