// ignore_for_file: public_member_api_docs, sort_constructors_first
class HttpResponse<E> {
  final E data;
  final String message;
  final int? statusCode;

  HttpResponse({
    required this.data,
    required this.message,
    required this.statusCode,
  });
}
