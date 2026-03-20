abstract class LocalStorageService {
  Future<void> init();

  Future<void> put(String boxName, String key, dynamic value);

  T? get<T>(String boxName, String key, {T? defaultValue});

  Future<void> delete(String boxName, String key);

  Iterable<dynamic> getAll(String boxName);

  int count(String boxName);

  Future<void> saveSetting(String key, dynamic value);

  T? readSetting<T>(String key, {T? defaultValue});
}
