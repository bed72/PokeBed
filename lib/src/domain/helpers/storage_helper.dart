enum StorageResponse {
  get(value: 'storageErrorGet'),
  save(value: 'storageErrorSave'),
  clear(value: 'storageErrorClear'),
  delete(value: 'storageErrorDelete'),
  generic(value: 'storageErrorGeneric');

  final String value;

  const StorageResponse({required this.value});
}
