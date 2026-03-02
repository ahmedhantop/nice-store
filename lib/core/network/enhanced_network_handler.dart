import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/network/base_repository.dart';
import 'package:nicestore/core/network/cache_manager.dart';
import 'package:nicestore/core/network/custom_network_handler.dart';
import 'package:nicestore/core/network/dio_client.dart';
import 'package:nicestore/core/network/network_manager.dart';
import 'package:nicestore/core/network/network_result.dart';

/// Enhanced network handler with caching and offline support
class EnhancedNetworkHandler extends CustomNetworkHandler {
  EnhancedNetworkHandler(super.dio, this._cacheManager, this._ref);
  final CacheManager _cacheManager;
  final Ref _ref;

  /// GET request with caching support
  Future<NetworkResult<T>> getCached<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
    Duration? cacheTtl = const Duration(hours: 1),
    bool forceRefresh = false,
  }) async {
    final url = _buildUrl(endpoint, pathParameters);
    final cacheKey = _generateCacheKey(url, queryParameters);

    // Check network connectivity
    final isConnected = _ref.read(isConnectedProvider);

    // Try to get from cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _cacheManager.retrieve(cacheKey);
      if (cachedData != null) {
        try {
          final data = parser != null
              ? parser(jsonDecode(cachedData))
              : jsonDecode(cachedData) as T;

          return NetworkSuccess<T>(data);
        } catch (e) {
          // Invalid cache data, remove it
          await _cacheManager.remove(cacheKey);
        }
      }
    }

    // If offline and no cache, return error
    if (!isConnected) {
      return NetworkFailure<T>(
        'No internet connection and no cached data available',
      );
    }

    // Make network request
    final result = await get<T>(
      endpoint,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
      options: options,
      parser: parser,
    );

    // Cache successful results
    if (result.isSuccess && cacheTtl != null) {
      final success = result as NetworkSuccess<T>;
      await _cacheManager.store(
        cacheKey,
        jsonEncode(success.data),
        ttl: cacheTtl,
      );
    }

    return result;
  }

  /// POST request with optional caching of response
  Future<NetworkResult<T>> postCached<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
    Duration? cacheTtl,
    String? cacheKey,
  }) async {
    // Check network connectivity
    final isConnected = _ref.read(isConnectedProvider);

    if (!isConnected) {
      return NetworkFailure<T>('No internet connection available');
    }

    // Make network request
    final result = await post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
      options: options,
      parser: parser,
    );

    // Cache successful results if cache key and TTL provided
    if (result.isSuccess && cacheTtl != null && cacheKey != null) {
      final success = result as NetworkSuccess<T>;
      await _cacheManager.store(
        cacheKey,
        jsonEncode(success.data),
        ttl: cacheTtl,
      );
    }

    return result;
  }

  /// Batch requests with caching support
  Future<List<NetworkResult<T>>> batchCachedRequests<T>(
    List<BatchRequest<T>> requests, {
    bool failFast = false,
  }) async {
    final futures = requests
        .map(
          (request) => getCached<T>(
            request.endpoint,
            queryParameters: request.queryParameters,
            pathParameters: request.pathParameters,
            options: request.options,
            parser: request.parser,
            cacheTtl: request.cacheTtl,
            forceRefresh: request.forceRefresh,
          ),
        )
        .toList();

    return batchRequests(futures, failFast: failFast);
  }

  /// Invalidate cache for specific endpoint
  Future<void> invalidateCache(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
  }) async {
    final url = _buildUrl(endpoint, pathParameters);
    final cacheKey = _generateCacheKey(url, queryParameters);
    await _cacheManager.remove(cacheKey);
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _cacheManager.clearAll();
  }

  /// Build URL with path parameters
  String _buildUrl(String endpoint, Map<String, dynamic>? pathParameters) {
    if (pathParameters == null || pathParameters.isEmpty) {
      return endpoint;
    }

    var url = endpoint;
    pathParameters.forEach((key, value) {
      url = url.replaceAll('{$key}', value.toString());
    });
    return url;
  }

  /// Generate cache key from URL and query parameters
  String _generateCacheKey(String url, Map<String, dynamic>? queryParams) {
    final buffer = StringBuffer(url);

    if (queryParams != null && queryParams.isNotEmpty) {
      final sortedKeys = queryParams.keys.toList()..sort();
      buffer.write('?');

      for (var i = 0; i < sortedKeys.length; i++) {
        final key = sortedKeys[i];
        buffer.write('$key=${queryParams[key]}');
        if (i < sortedKeys.length - 1) {
          buffer.write('&');
        }
      }
    }

    return buffer.toString().hashCode.toString();
  }
}

/// Batch request configuration
class BatchRequest<T> {
  BatchRequest({
    required this.endpoint,
    this.queryParameters,
    this.pathParameters,
    this.options,
    this.parser,
    this.cacheTtl = const Duration(hours: 1),
    this.forceRefresh = false,
  });
  final String endpoint;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? pathParameters;
  final Options? options;
  final T Function(dynamic data)? parser;
  final Duration? cacheTtl;
  final bool forceRefresh;
}

/// Provider for EnhancedNetworkHandler
final enhancedNetworkHandlerProvider = Provider<EnhancedNetworkHandler>((ref) {
  final dioClient = ref.read(dioClientProvider);

  final cacheManager = ref.read(cacheManagerProvider);

  return EnhancedNetworkHandler(dioClient.dio, cacheManager, ref);
});
