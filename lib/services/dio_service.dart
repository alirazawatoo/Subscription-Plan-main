import 'package:dio/dio.dart';

import '../app/app.logger.dart';
import '../models/application_models.dart';
import '../utils/dio_client.dart';
import 'api_service.dart';

class DioService implements ApiService {
  final log = getLogger('DioService');

  @override
  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  }) async {
    final dio = DioClient.dio;

    final Response response = await dio.get(
      url,
      queryParameters: {...queryParameters},
    );

    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<ApiResponse> post({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool isAuthenticated = false,
  }) async {
    final dio = DioClient.dio;

    final Response response = await dio.post(
      url,
      queryParameters: {...queryParameters},
      data: FormData.fromMap(body),
    );

    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<ApiResponse> put({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool isAuthenticated = false,
  }) async {
    final dio = DioClient.dio;

    final Response response = await dio.put(
      url,
      queryParameters: {...queryParameters},
      data: FormData.fromMap(body),
    );

    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<ApiResponse> delete({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  }) async {
    final dio = DioClient.dio;

    final Response response = await dio.delete(
      url,
      queryParameters: {...queryParameters},
    );

    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}
