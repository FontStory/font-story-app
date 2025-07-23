import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveManager {
  final Map<String, Box> _boxes = {};

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<T>> _openBox<T>(String boxName) async {
    if (_boxes.containsKey(boxName)) {
      return _boxes[boxName] as Box<T>;
    }
    final box = await Hive.openBox<T>(boxName);
    _boxes[boxName] = box;
    return box;
  }

  Future<void> create<T>(String boxName, String key, T item) async {
    final box = await _openBox<T>(boxName);
    await box.put(key, item);
  }

  Future<void> update<T>(String boxName, String key, T item) async =>
      create<T>(boxName, key, item);

  Future<void> delete<T>(String boxName, String key) async {
    final box = await _openBox<T>(boxName);
    await box.delete(key);
  }

  Future<List<T>> readAll<T>(String boxName) async {
    final box = await _openBox<T>(boxName);
    return box.values.cast<T>().toList();
  }

  Future<T?> read<T>(String boxName, String key) async {
    final box = await _openBox<T>(boxName);
    return box.get(key);
  }

  Future<bool> isEmpty(String boxName) async {
    final box = await _openBox(boxName);
    return box.isEmpty;
  }

  Future<void> clear(String boxName) async {
    final box = await _openBox(boxName);
    await box.clear();
  }

  Future<void> closeBox(String boxName) async {
    final box = _boxes[boxName];
    if (box != null && box.isOpen) {
      await box.close();
      _boxes.remove(boxName);
    }
  }

  /// Retrieves all keys from the specified box.
  Future<Iterable<String>> getKeys(String boxName) async {
    final box = await _openBox<dynamic>(boxName);
    return box.keys.cast<String>();
  }
}
