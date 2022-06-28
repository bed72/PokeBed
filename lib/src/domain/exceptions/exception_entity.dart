import 'package:bed/src/domain/helpers/http_helper.dart';
import 'package:bed/src/domain/helpers/storage_helper.dart';

abstract class HandleExceptionEntity implements Exception {}

class StorageExceptionEntity extends HandleExceptionEntity {
  late final String message;
  late StorageResponse code;

  StorageExceptionEntity({
    required this.code,
    required this.message,
  });
}

class HttpExceptionEntity extends HandleExceptionEntity {
  late HttpResponse code;
  late final String message;

  HttpExceptionEntity({
    required this.code,
    required this.message,
  });
}
