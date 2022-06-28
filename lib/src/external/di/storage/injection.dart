import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bed/src/domain/usecases/storage/storage_usecase.dart';

import 'package:bed/src/external/singletons/storage_singleton.dart';
import 'package:bed/src/external/adapters/storage/storage_adapter.dart';

import 'package:bed/src/data/clients/storage/storage_client.dart';
import 'package:bed/src/data/usecases/storage/local_storage_usecase.dart';

final storageProvider = [
  Provider<SharedPreferences>.value(
    value: StorageSingleton.instance.preferences,
  ),
  Provider<StorageClient>(
    create: (context) => StorageAdapter(
      context.read<SharedPreferences>(),
    ),
  ),
  Provider<StorageUsecase>(
    create: (context) => LocalStorageUsecase(
      context.read<StorageClient>(),
    ),
  ),
];
