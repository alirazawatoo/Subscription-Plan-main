import 'package:dio/dio.dart';
import '../constants/constants.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    connectTimeout: connectionTimeout,
    receiveTimeout: receiveTimeout,
    contentType: Headers.jsonContentType,
  );

  static Dio get dio => Dio(options);
}
