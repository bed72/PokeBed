import 'package:dio/dio.dart';

import 'package:provider/provider.dart';

import 'package:bed/src/domain/usecases/http/http_usecase.dart';

import 'package:bed/src/external/adapters/http/http_adapter.dart';

import 'package:bed/src/data/clients/http/http_client.dart';
import 'package:bed/src/data/usecases/http/remote_http_usecase.dart';

final httpProvider = [
  Provider<Dio>.value(
    value: Dio(),
  ),
  Provider<HttpClient>(
    create: (context) => HttpAdapter(
      context.read<Dio>(),
    ),
  ),
  Provider<HttpUseCase>(
    create: (context) => RemoteHttpUseCase(
      context.read<HttpClient>(),
    ),
  ),
];
