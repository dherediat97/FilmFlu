class HomeException implements Exception {
  final String message;

  HomeException({required this.message});
}

class AuthException extends HomeException {
  AuthException({required super.message});
}

class MovieListException extends HomeException {
  MovieListException({required super.message});
}

class MovieDetailException extends HomeException {
  MovieDetailException({required super.message});
}

class MovieFavoriteGetException extends HomeException {
  MovieFavoriteGetException({required super.message});
}

class MovieFavoriteAddException extends HomeException {
  MovieFavoriteAddException({required super.message});
}

class MovieFavoriteRemoveException extends HomeException {
  MovieFavoriteRemoveException({required super.message});
}

class MovieFavoriteClearException extends HomeException {
  MovieFavoriteClearException({required super.message});
}

class MovieFavoriteNotFound extends HomeException {
  MovieFavoriteNotFound({required super.message});
}
