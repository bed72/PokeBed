import 'package:dio/dio.dart';

import 'package:bed/src/domain/helpers/http_helper.dart';
import 'package:bed/src/domain/constants/app_constant.dart';

import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/left_entity.dart';
import 'package:bed/src/domain/entities/either/right_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

import 'package:bed/src/data/clients/http/http_client.dart';

class HttpAdapter implements HttpClient {
  late final Dio _http;

  HttpAdapter(this._http) {
    configureHttp();
  }

  @override
  void configureHttp() {
    _configureDio();
  }

  void _configureDio() {
    _http.options = BaseOptions(
      maxRedirects: 2,
      sendTimeout: 6000,
      receiveTimeout: 6000,
      connectTimeout: 6000,
      responseType: ResponseType.json,
      baseUrl: AppContants.urlPokeApi,
    );
  }

  @override
  Future<Either<HttpExceptionEntity, Map<String, dynamic>>> get({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    Response<dynamic> response = Response(
      requestOptions: RequestOptions(
        path: url,
        sendTimeout: 6,
        headers: _buildHeaders(headers),
        responseType: ResponseType.json,
      ),
    );

    final defaultHeaders = _buildHeaders(headers);

    try {
      response = await _http.get(
        url,
        options: Options(headers: defaultHeaders),
      );
    } on DioError catch (error) {
      return Left(_buildResponseError(error));
    }

    return Right(_buildResponseSuccess(response));
  }

  Map<String, String> _buildEmptyBody() => {
        'response': 'ok',
      };

  Map<String, String> _buildHeaders(Map<String, String>? headers) =>
      headers?.cast<String, String>() ?? {}
        ..addAll({
          'accept': 'application/json',
          'content-type': 'application/json',
        });

  Map<String, dynamic> _buildResponseSuccess(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.data.isEmpty ? _buildEmptyBody() : response.data;
      case 204:
        return _buildEmptyBody();
      default:
        return _buildEmptyBody();
    }
  }

  HttpExceptionEntity _buildResponseError(DioError error) {
    switch (error.response?.statusCode ?? 500) {
      case 400:
        return HttpExceptionEntity(
          code: HttpResponse.badRequest,
          message: HttpResponse.badRequest.value,
        );
      case 401:
        return HttpExceptionEntity(
          code: HttpResponse.unauthorized,
          message: HttpResponse.unauthorized.value,
        );
      case 403:
        return HttpExceptionEntity(
          code: HttpResponse.forbidden,
          message: HttpResponse.forbidden.value,
        );
      case 404:
        return HttpExceptionEntity(
          code: HttpResponse.notFound,
          message: HttpResponse.notFound.value,
        );
      default:
        return HttpExceptionEntity(
          code: HttpResponse.serverError,
          message: HttpResponse.serverError.value,
        );
    }
  }
}
