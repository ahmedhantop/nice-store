/// A sealed class representing the result of a network operation
sealed class NetworkResult<T> {
  const NetworkResult();
}

/// Success result containing data
class NetworkSuccess<T> extends NetworkResult<T> {
  const NetworkSuccess(this.data, {this.statusCode, this.headers});
  final T data;
  final int? statusCode;
  final Map<String, dynamic>? headers;
}

/// Failure result containing error information
class NetworkFailure<T> extends NetworkResult<T> {
  const NetworkFailure(
    this.message, {
    this.statusCode,
    this.errorCode,
    this.originalError,
  });
  final String message;
  final int? statusCode;
  final String? errorCode;
  final dynamic originalError;

  bool get isNetworkError => statusCode == null;
  bool get isServerError => statusCode != null && statusCode! >= 500;
  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! < 500;
  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
}

/// Extension methods for NetworkResult
extension NetworkResultExtension<T> on NetworkResult<T> {
  /// Returns true if the result is a success
  bool get isSuccess => this is NetworkSuccess<T>;

  /// Returns true if the result is a failure
  bool get isFailure => this is NetworkFailure<T>;

  /// Returns the data if success, null if failure
  T? get dataOrNull => switch (this) {
    final NetworkSuccess<T> success => success.data,
    NetworkFailure<T> _ => null,
  };

  /// Returns the error if failure, null if success
  NetworkFailure<T>? get errorOrNull => switch (this) {
    NetworkSuccess<T> _ => null,
    final NetworkFailure<T> failure => failure,
  };

  /// Executes onSuccess if result is success, onFailure if failure
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(NetworkFailure<T> failure) onFailure,
  }) => switch (this) {
    final NetworkSuccess<T> success => onSuccess(success.data),
    final NetworkFailure<T> failure => onFailure(failure),
  };

  /// Maps the data if success, returns failure unchanged
  NetworkResult<R> map<R>(R Function(T data) mapper) => switch (this) {
    final NetworkSuccess<T> success => NetworkSuccess(
      mapper(success.data),
      statusCode: success.statusCode,
      headers: success.headers,
    ),
    final NetworkFailure<T> failure => NetworkFailure(
      failure.message,
      statusCode: failure.statusCode,
      errorCode: failure.errorCode,
      originalError: failure.originalError,
    ),
  };
}
