import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

abstract class HttpClient {
  void configureHttp();

  Future<Either<HttpExceptionEntity, Map<String, dynamic>>> get({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}
