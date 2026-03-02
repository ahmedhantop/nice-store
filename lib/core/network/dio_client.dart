import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://fakestoreapi.com",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
}
