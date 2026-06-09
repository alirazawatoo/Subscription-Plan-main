import '../models/application_models.dart';

abstract class ApiService {
  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  });

  Future<ApiResponse> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  });

  Future<ApiResponse> put({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  });

  Future<ApiResponse> delete({
    required String url,
    Map<String, dynamic> queryParameters = const {},
    bool isAuthenticated = false,
  });
}
