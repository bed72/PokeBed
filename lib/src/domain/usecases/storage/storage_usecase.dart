import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

abstract class StorageUsecase {
  Future<Either<StorageExceptionEntity, bool>> clear();
  Either<StorageExceptionEntity, String> get({required String key});
  Future<Either<StorageExceptionEntity, bool>> delete({required String key});
  Future<Either<StorageExceptionEntity, bool>> save({
    required String key,
    required String value,
  });
}
