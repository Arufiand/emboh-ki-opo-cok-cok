import 'package:dio/dio.dart';
import 'package:epms_flutter/src/app_config.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        request: true,
      ),
    );
  }

  Dio get dio => _dio;
}
