import 'package:dio/dio.dart';
import 'package:nicestore/core/network/network_result.dart';

/// Custom network handler with enhanced error handling and result pattern
class CustomNetworkHandler {

  CustomNetworkHandler(this._dio);
  final Dio _dio;

  /// Generic GET request with result pattern
  Future<NetworkResult<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final url = _buildUrl(endpoint, pathParameters);

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic POST request with result pattern
  Future<NetworkResult<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final url = _buildUrl(endpoint, pathParameters);

      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic PUT request with result pattern
  Future<NetworkResult<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final url = _buildUrl(endpoint, pathParameters);

      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic PATCH request with result pattern
  Future<NetworkResult<T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final url = _buildUrl(endpoint, pathParameters);

      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Generic DELETE request with result pattern
  Future<NetworkResult<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Options? options,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final url = _buildUrl(endpoint, pathParameters);

      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Upload file with progress tracking
  Future<NetworkResult<T>> uploadFile<T>(
    String endpoint,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    ProgressCallback? onSendProgress,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        ...?additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return _handleResponse<T>(response, parser);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  /// Download file with progress tracking
  Future<NetworkResult<String>> downloadFile(
    String endpoint,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        endpoint,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      return NetworkSuccess(savePath);
    } catch (e) {
      return _handleError<String>(e);
    }
  }

  /// Batch requests with concurrent execution
  Future<List<NetworkResult<T>>> batchRequests<T>(
    List<Future<NetworkResult<T>>> requests, {
    bool failFast = false,
  }) async {
    if (failFast) {
      // Stop on first error
      final results = <NetworkResult<T>>[];
      for (final request in requests) {
        final result = await request;
        results.add(result);
        if (result.isFailure) break;
      }
      return results;
    } else {
      // Execute all requests regardless of failures
      return Future.wait(requests);
    }
  }

  /// Retry mechanism for failed requests
  Future<NetworkResult<T>> retryRequest<T>(
    Future<NetworkResult<T>> Function() request, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(NetworkFailure failure)? shouldRetry,
  }) async {
    var result = await request();

    var retryCount = 0;
    while (result.isFailure && retryCount < maxRetries) {
      final failure = result as NetworkFailure<T>;

      // Check if we should retry this specific error
      if (shouldRetry != null && !shouldRetry(failure)) {
        break;
      }

      // Default retry logic: retry on network errors and 5xx server errors
      if (!failure.isNetworkError && !failure.isServerError) {
        break;
      }

      retryCount++;
      await Future.delayed(delay * retryCount); // Exponential backoff
      result = await request();
    }

    return result;
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

  /// Handle successful response
  NetworkResult<T> _handleResponse<T>(
    Response response,
    T Function(dynamic data)? parser,
  ) {
    try {
      final data = parser != null ? parser(response.data) : response.data as T;

      return NetworkSuccess<T>(
        data,
        statusCode: response.statusCode,
        headers: response.headers.map,
      );
    } catch (e) {
      return NetworkFailure<T>(
        'Failed to parse response: ${e.toString()}',
        statusCode: response.statusCode,
        originalError: e,
      );
    }
  }

  /// Handle errors and convert to NetworkFailure
  NetworkFailure<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      return _handleDioError<T>(error);
    }

    return NetworkFailure<T>(
      'Unexpected error: ${error.toString()}',
      originalError: error,
    );
  }

  /// Handle Dio-specific errors
  NetworkFailure<T> _handleDioError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailure<T>(
          'Connection timeout. Please check your internet connection.',
          originalError: error,
        );

      case DioExceptionType.sendTimeout:
        return NetworkFailure<T>(
          'Request timeout. Please try again.',
          originalError: error,
        );

      case DioExceptionType.receiveTimeout:
        return NetworkFailure<T>(
          'Response timeout. Please try again.',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        return _handleHttpError<T>(error);

      case DioExceptionType.cancel:
        return NetworkFailure<T>(
          'Request was cancelled.',
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure<T>(
          'No internet connection. Please check your network.',
          originalError: error,
        );

      case DioExceptionType.badCertificate:
        return NetworkFailure<T>(
          'Security certificate error.',
          originalError: error,
        );

      case DioExceptionType.unknown:
        return NetworkFailure<T>(
          'An unexpected error occurred: ${error.message}',
          originalError: error,
        );
    }
  }

  /// Handle HTTP status code errors
  NetworkFailure<T> _handleHttpError<T>(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    // Try to extract error message from response
    var message = 'Request failed';
    String? errorCode;

    if (responseData is Map<String, dynamic>) {
      message =
          responseData['message'] ??
          responseData['error'] ??
          responseData['detail'] ??
          message;
      errorCode =
          responseData['code']?.toString() ??
          responseData['error_code']?.toString();
    }

    switch (statusCode) {
      case 400:
        message = 'Bad request: $message';
        break;
      case 401:
        message = 'Unauthorized: Please login again';
        break;
      case 403:
        message = 'Forbidden: You don\'t have permission';
        break;
      case 404:
        message = 'Not found: The requested resource was not found';
        break;
      case 422:
        message = 'Validation error: $message';
        break;
      case 429:
        message = 'Too many requests: Please try again later';
        break;
      case 500:
        message = 'Server error: Please try again later';
        break;
      case 502:
        message = 'Bad gateway: Server is temporarily unavailable';
        break;
      case 503:
        message = 'Service unavailable: Please try again later';
        break;
      default:
        message = 'Request failed with status $statusCode: $message';
    }

    return NetworkFailure<T>(
      message,
      statusCode: statusCode,
      errorCode: errorCode,
      originalError: error,
    );
  }
}
