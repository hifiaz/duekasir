import 'package:dio/dio.dart';
import 'package:due_kasir/utils/env.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://graph.facebook.com/v19.0/310278488839005',
      contentType: Headers.jsonContentType,
      headers: {
        "authorization": "Bearer ${Environment.token}",
      }
    ),
  );

  DioClient._();

  static final instance = DioClient._();

  Dio get dio => _dio;
}