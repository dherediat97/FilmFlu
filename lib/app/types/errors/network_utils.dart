import 'package:dio/dio.dart';
import 'package:FilmFlu/app/types/errors/network_error.dart';

NetworkError getErrorFromDioError(DioException error) {
  final NetworkError networkExceptions;
  switch (error.type) {
    case DioExceptionType.cancel:
      networkExceptions = const NetworkError.requestCancelled();
      break;
    case DioExceptionType.connectionTimeout:
      networkExceptions = const NetworkError.requestTimeout();
      break;
    case DioExceptionType.unknown:
      if (error.toString().contains('is not a subtype of')) {
        networkExceptions = const NetworkError.unableToProcess();
      } else {
        networkExceptions = const NetworkError.noInternetConnection();
      }
      break;
    case DioExceptionType.receiveTimeout:
      networkExceptions = const NetworkError.sendTimeout();
      break;
    case DioExceptionType.badResponse:
      final errorDescription =
          error.response?.data?['error']?['error_description'];
      final errorType = error.response?.data?['error']?['error_type'];
      if (errorType != null && errorType == 'INFO_NOT_MATCHING') {
        return const NetworkError.infoNotMatching();
      }

      if (errorDescription != null && errorDescription is List) {
        return NetworkError.badRequestListErrors(
          (errorDescription).map((e) => e as String).toList(),
        );
      }

      networkExceptions = _checkStatusCode(error.response?.statusCode);
      break;
    case DioExceptionType.sendTimeout:
      networkExceptions = const NetworkError.sendTimeout();
      break;
    case DioExceptionType.badCertificate:
      networkExceptions = const NetworkError.badRequest();
      break;
    case DioExceptionType.connectionError:
      networkExceptions = const NetworkError.badRequest();
      break;
  }

  return networkExceptions;
}

NetworkError _checkStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return const NetworkError.badRequest();
    case 401:
      return const NetworkError.unauthorizedRequest();
    case 403:
      return const NetworkError.forbidden();
    case 404:
      return const NetworkError.notFound('Not found');
    case 409:
      return const NetworkError.conflict();
    case 408:
      return const NetworkError.requestTimeout();
    case 500:
      return const NetworkError.internalServerError();
    case 503:
      return const NetworkError.serviceUnavailable();
    default:
      var responseCode = statusCode;
      return NetworkError.defaultError(
        'Received invalid status code: $responseCode',
      );
  }
}
