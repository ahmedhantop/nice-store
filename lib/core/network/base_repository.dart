import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/network/custom_network_handler.dart';
import 'package:nicestore/core/network/dio_client.dart';
import 'package:nicestore/core/network/network_result.dart';

/// Base repository class that provides common network operations
abstract class BaseRepository {
  BaseRepository(this._networkHandler);
  final CustomNetworkHandler _networkHandler;

  /// Get list of items with optional query parameters
  Future<NetworkResult<List<T>>> getList<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async => _networkHandler.get<List<T>>(
    endpoint,
    queryParameters: queryParameters,
    parser: (data) {
      final items = data is List
          ? data
          : (data as Map<String, dynamic>)['data'] as List<dynamic>;

      return items
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    },
  );

  /// Get single item by ID
  Future<NetworkResult<T>> getById<T>(
    String endpoint,
    String id, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async => _networkHandler.get<T>(
    endpoint.replaceAll('{id}', id),
    parser: (data) => fromJson(data as Map<String, dynamic>),
  );

  /// Create new item
  Future<NetworkResult<T>> create<T>(
    String endpoint,
    Map<String, dynamic> data, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async => _networkHandler.post<T>(
    endpoint,
    data: data,
    parser: (responseData) => fromJson(responseData as Map<String, dynamic>),
  );

  /// Update existing item
  Future<NetworkResult<T>> update<T>(
    String endpoint,
    String id,
    Map<String, dynamic> data, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async => _networkHandler.put<T>(
    endpoint.replaceAll('{id}', id),
    data: data,
    parser: (responseData) => fromJson(responseData as Map<String, dynamic>),
  );

  /// Delete item by ID
  Future<NetworkResult<bool>> delete(String endpoint, String id) async =>
      _networkHandler.delete<bool>(
        endpoint.replaceAll('{id}', id),
        parser: (data) => true,
      );

  /// Search items with query
  Future<NetworkResult<List<T>>> search<T>(
    String endpoint,
    String query, {
    Map<String, dynamic>? additionalParams,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final queryParams = {'q': query, ...?additionalParams};

    return _networkHandler.get<List<T>>(
      endpoint,
      queryParameters: queryParams,
      parser: (data) {
        final items = data is List
            ? data
            : (data as Map<String, dynamic>)['data'] as List<dynamic>;

        return items
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();
      },
    );
  }

  /// Upload file
  Future<NetworkResult<String>> uploadFile(
    String endpoint,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
  }) async => _networkHandler.uploadFile<String>(
    endpoint,
    filePath,
    fieldName: fieldName,
    additionalData: additionalData,
    parser: (data) => (data as Map<String, dynamic>)['url'] ?? '',
  );
}

// Dio client provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Provider for CustomNetworkHandler
final customNetworkHandlerProvider = Provider<CustomNetworkHandler>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return CustomNetworkHandler(dioClient.dio);
});

/// Provider for BaseRepository
final baseRepositoryProvider = Provider<BaseRepository>(
  (ref) => _BaseRepositoryImpl(ref.read(customNetworkHandlerProvider)),
);

/// Concrete implementation of BaseRepository
class _BaseRepositoryImpl extends BaseRepository {
  _BaseRepositoryImpl(super.networkHandler);
}
