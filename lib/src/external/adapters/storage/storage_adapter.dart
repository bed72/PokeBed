import 'package:shared_preferences/shared_preferences.dart';

import 'package:bed/src/domain/helpers/storage_helper.dart';
import 'package:bed/src/domain/exceptions/exception_entity.dart';
import 'package:bed/src/domain/entities/either/left_entity.dart';
import 'package:bed/src/domain/entities/either/right_entity.dart';
import 'package:bed/src/domain/entities/either/either_entity.dart';

import 'package:bed/src/data/clients/storage/storage_client.dart';

class StorageAdapter implements StorageClient {
  late final SharedPreferences _storage;

  StorageAdapter(this._storage);

  @override
  Future<Either<StorageExceptionEntity, bool>> clear() async {
    try {
      final response = await _storage.clear();

      return Right(response);
    } catch (exception) {
      return Left(
        StorageExceptionEntity(
          code: StorageResponse.clear,
          message: exception.toString(),
        ),
      );
    }
  }

  @override
  Either<StorageExceptionEntity, String> get(String key) {
    try {
      final response = _storage.getString(key) ?? '';

      return Right(response);
    } catch (exception) {
      return Left(
        StorageExceptionEntity(
          code: StorageResponse.get,
          message: exception.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<StorageExceptionEntity, bool>> delete(String key) async {
    try {
      final response = await _storage.remove(key);

      return Right(response);
    } catch (exception) {
      return Left(
        StorageExceptionEntity(
          code: StorageResponse.delete,
          message: exception.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<StorageExceptionEntity, bool>> save({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.remove(key);
      final response = await _storage.setString(key, value);

      return Right(response);
    } catch (exception) {
      return Left(
        StorageExceptionEntity(
          code: StorageResponse.save,
          message: exception.toString(),
        ),
      );
    }
  }
}
