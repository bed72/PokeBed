enum StorageResponse {
  get,
  save,
  clear,
  delete,
  generic,
}

extension StorageResponseExtension on StorageResponse {
  String get value {
    switch (this) {
      case StorageResponse.get:
        return 'storageErrorGet';
      case StorageResponse.save:
        return 'storageErrorSave';
      case StorageResponse.clear:
        return 'storageErrorClear';
      case StorageResponse.delete:
        return 'storageErrorDelete';
      case StorageResponse.generic:
        return 'storageErrorGeneric';
      default:
        return 'storageGeneric';
    }
  }
}
