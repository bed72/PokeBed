import 'package:bed/src/data/clients/storage/storage_client.dart';

import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';
import 'package:bed/src/domain/usecases/storage/storage_usecase.dart';

class LocalStorageUsecase implements StorageUsecase {
  late final StorageClient _storageClient;

  LocalStorageUsecase(this._storageClient);

  @override
  Future<Either<StorageExceptionEntity, bool>> clear() async =>
      await _storageClient.clear();

  @override
  Either<StorageExceptionEntity, String> get({required String key}) =>
      _storageClient.get(key);

  @override
  Future<Either<StorageExceptionEntity, bool>> save({
    required String key,
    required String value,
  }) async =>
      await _storageClient.save(key: key, value: value);

  @override
  Future<Either<StorageExceptionEntity, bool>> delete(
          {required String key}) async =>
      await _storageClient.delete(key);
}
