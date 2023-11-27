import 'package:FilmFlu/core/entities/http_response.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:dio/dio.dart';

class DioClientHttp implements ClientHttp {
  @override
  Future<HttpResponse> get(
      {required String url, Map<String, dynamic>? params}) async {
    var dio = Dio();
    final response = await dio.get(url,
        options: Options(responseType: ResponseType.json),
        queryParameters: params);
    HttpResponse httpResponse = HttpResponse(
      message: "",
      statusCode: response.statusCode ?? 0,
      data: response.data,
    );
    return httpResponse;
  }
}
