import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bed/src/domain/usecases/storage/storage_usecase.dart';

import 'package:bed/src/external/singletons/storage_singleton.dart';
import 'package:bed/src/external/adapters/storage/storage_adapter.dart';

import 'package:bed/src/data/clients/storage/storage_client.dart';
import 'package:bed/src/data/usecases/storage/local_storage_usecase.dart';

class StorageInject {
  late final GetIt _getIt;

  StorageInject(this._getIt);

  void di() {
    _getIt.registerLazySingleton(() => _getIt<StorageSingleton>());

    _getIt.registerLazySingleton<StorageClient>(
      () => StorageAdapter(
        _getIt<SharedPreferences>(),
      ),
    );

    _getIt.registerLazySingleton<StorageUsecase>(
      () => LocalStorageUsecase(
        _getIt<StorageClient>(),
      ),
    );
  }
}
