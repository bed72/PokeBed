import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:bed/src/domain/usecases/http/http_usecase.dart';

import 'package:bed/src/external/adapters/http/http_adapter.dart';

import 'package:bed/src/data/clients/http/http_client.dart';
import 'package:bed/src/data/usecases/http/remote_http_usecase.dart';

class HttpInject {
  late final GetIt _getIt;

  HttpInject(this._getIt);

  void di() {
    _getIt.registerLazySingleton<Dio>(() => Dio());

    _getIt.registerLazySingleton<HttpClient>(
      () => HttpAdapter(
        _getIt<Dio>(),
      ),
    );

    _getIt.registerLazySingleton<HttpUseCase>(
      () => RemoteHttpUseCase(
        _getIt<HttpClient>(),
      ),
    );
  }
}
