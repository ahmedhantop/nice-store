import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cache entry with expiration
class CacheEntry {
  CacheEntry(this.data, this.timestamp, this.ttl);

  factory CacheEntry.fromJson(Map<String, dynamic> json) => CacheEntry(
    json['data'] ?? '',
    DateTime.parse(json['timestamp'] ?? ''),
    json['ttl'] != null ? Duration(milliseconds: json['ttl'] ?? 0) : null,
  );
  final String data;
  final DateTime timestamp;
  final Duration? ttl;

  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().difference(timestamp) > ttl!;
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'timestamp': timestamp.toIso8601String(),
    'ttl': ttl?.inMilliseconds,
  };
}

/// Simple cache manager using SharedPreferences
class CacheManager {
  static const String _cachePrefix = 'network_cache_';
  SharedPreferences? _prefs;

  /// Initialize cache manager
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Store data in cache
  Future<void> store(
    String key,
    String data, {
    Duration? ttl = const Duration(hours: 1),
  }) async {
    await init();

    final entry = CacheEntry(data, DateTime.now(), ttl);
    final cacheKey = _cachePrefix + key;

    await _prefs!.setString(cacheKey, jsonEncode(entry.toJson()));
  }

  /// Retrieve data from cache
  Future<String?> retrieve(String key) async {
    await init();

    final cacheKey = _cachePrefix + key;
    final cachedData = _prefs!.getString(cacheKey);

    if (cachedData == null) return null;

    try {
      final entry = CacheEntry.fromJson(jsonDecode(cachedData));

      if (entry.isExpired) {
        await remove(key);
        return null;
      }

      return entry.data;
    } catch (e) {
      // Invalid cache entry, remove it
      await remove(key);
      return null;
    }
  }

  /// Remove data from cache
  Future<void> remove(String key) async {
    await init();

    final cacheKey = _cachePrefix + key;
    await _prefs!.remove(cacheKey);
  }

  /// Clear all cache
  Future<void> clearAll() async {
    await init();

    final keys = _prefs!
        .getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .toList();

    for (final key in keys) {
      await _prefs!.remove(key);
    }
  }

  /// Check if key exists in cache and is not expired
  Future<bool> exists(String key) async {
    final data = await retrieve(key);
    return data != null;
  }

  /// Get cache size (number of entries)
  Future<int> getCacheSize() async {
    await init();

    return _prefs!
        .getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .length;
  }

  /// Clean expired entries
  Future<void> cleanExpired() async {
    await init();

    final keys = _prefs!
        .getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .toList();

    for (final cacheKey in keys) {
      final cachedData = _prefs!.getString(cacheKey);
      if (cachedData != null) {
        try {
          final entry = CacheEntry.fromJson(jsonDecode(cachedData));
          if (entry.isExpired) {
            await _prefs!.remove(cacheKey);
          }
        } catch (e) {
          // Invalid entry, remove it
          await _prefs!.remove(cacheKey);
        }
      }
    }
  }
}

/// Provider for CacheManager
final cacheManagerProvider = Provider<CacheManager>((ref) => CacheManager());
