import 'package:dio/dio.dart';
import '../constants/constants.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: connectionTimeout),
    receiveTimeout: const Duration(seconds: receiveTimeout),
    contentType: Headers.jsonContentType,
  );

  static Dio get dio => Dio(options);
}
