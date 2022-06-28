import 'package:bed/src/data/clients/http/http_client.dart';

import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/usecases/http/http_usecase.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

class RemoteHttpUseCase implements HttpUseCase {
  late final HttpClient _httpClient;

  RemoteHttpUseCase(this._httpClient);

  @override
  Future<Either<HttpExceptionEntity, Map<String, dynamic>>> get({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async =>
      await _httpClient.get(url: url);
}
