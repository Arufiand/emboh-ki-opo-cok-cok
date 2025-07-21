import 'package:hive_flutter/hive_flutter.dart'; // For Hive storage

abstract class LocalStorageService {
  Future<void> init();
  Future<Box<T>> openBox<T>(String name);
  Future<void> put<T>(String boxName, String key, T value);
  Future<T?> get<T>(String boxName, String key);
  Future<void> delete<T>(String boxName, String key);
  Future<void> clearBox(String boxName);
  Future<bool> boxExists(String boxName);
}

class LocalStorageServiceImpl implements LocalStorageService {
  late final HiveInterface _hive;

  LocalStorageServiceImpl(this._hive);

  @override
  Future<void> init() async {
    await _hive.initFlutter();
    // init adapter disini nanti
  }

  @override
  Future<Box<T>> openBox<T>(String name) async {
    if (!_hive.isBoxOpen(name)) {
      return await _hive.openBox<T>(name);
    }
    return _hive.box<T>(name);
  }

  /// Puts a value into a specified Hive box under a given key.
  @override
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Retrieves a value from a specified Hive box using its key.
  @override
  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Deletes a value from a specified Hive box using its key.
  @override
  Future<void> delete<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Clears all data from a specified Hive box.
  @override
  Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  /// Checks if a Hive box with the given name exists.
  @override
  Future<bool> boxExists(String boxName) async {
    return await _hive.boxExists(boxName);
  }
}
