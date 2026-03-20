import 'package:hive_flutter/hive_flutter.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';

class HiveService implements LocalStorageService {
  static const String settingsBox = 'settings';
  static const String chatsBox = 'chats';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<dynamic>(settingsBox),
      Hive.openBox<dynamic>(chatsBox),
    ]);
  }

  Box<dynamic> box(String boxName) => Hive.box<dynamic>(boxName);

  @override
  Future<void> put(String boxName, String key, dynamic value) async {
    await box(boxName).put(key, value);
  }

  @override
  T? get<T>(String boxName, String key, {T? defaultValue}) {
    return box(boxName).get(key, defaultValue: defaultValue) as T?;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    await box(boxName).delete(key);
  }

  @override
  Iterable<dynamic> getAll(String boxName) => box(boxName).values;

  @override
  int count(String boxName) => box(boxName).length;

  @override
  Future<void> saveSetting(String key, dynamic value) =>
      put(settingsBox, key, value);

  @override
  T? readSetting<T>(String key, {T? defaultValue}) =>
      get<T>(settingsBox, key, defaultValue: defaultValue);
}
