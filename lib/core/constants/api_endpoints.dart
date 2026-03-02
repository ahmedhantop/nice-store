class ApiEndpoints {
  // Base URL - Update this based on your environment
  static const String baseUrl = 'https://fakestoreapi.com/';

  // API Version
  static const String apiVersion = '$baseUrl/';

  // Full base URL with version
  //static const String fullBaseUrl = '$baseUrl';

  // Authentication Endpoints
  static const String login = 'auth/login';
  static const String sendOtp = 'auth/send-otp';
  static const String register = 'auth/register';
  static const String logout = 'auth/logout';
  static const String logoutAll = 'auth/logout-all';

  static const String products = '$apiVersion/products';
  static const String productDetails = 'all-products/{id}';

  // Utility Methods

  /// Replace path parameters in endpoint URLs
  /// Example: replacePathParams('/hotels/{id}', {'id': '123'}) returns '/hotels/123'
  static String replacePathParams(
    String endpoint,
    Map<String, dynamic> params,
  ) {
    var result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }

  /// Get full URL with base URL
  static String getFullUrl(String endpoint) => endpoint;

  /// Get URL with path parameters replaced
  static String getUrlWithParams(String endpoint, Map<String, dynamic> params) {
    final replacedEndpoint = replacePathParams(endpoint, params);
    return getFullUrl(replacedEndpoint);
  }

  // Environment-specific configurations
  static const Map<String, String> environments = {
    'development': 'https://fakestoreapi.com/',
    'staging': 'https://fakestoreapi.com/',
    'production': 'https://fakestoreapi.com/',
  };

  /// Get base URL for specific environment
  static String getBaseUrlForEnvironment(String environment) =>
      environments[environment] ?? environments['production']!;

  // API Response Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  static const int statusServiceUnavailable = 503;

  // Request Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerAccept = 'Accept';
  static const String headerUserAgent = 'User-Agent';
  static const String headerAcceptLanguage = 'Accept-Language';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String contentTypeUrlEncoded =
      'application/x-www-form-urlencoded';

  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
