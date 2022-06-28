import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

abstract class StorageClient {
  Future<Either<StorageExceptionEntity, bool>> clear();
  Either<StorageExceptionEntity, String> get(String key);
  Future<Either<StorageExceptionEntity, bool>> delete(String key);
  Future<Either<StorageExceptionEntity, bool>> save({
    required String key,
    required String value,
  });
}
