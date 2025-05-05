import 'package:comerciou_pdv/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio}) {
    dio.options.baseUrl = 'https://api.comerciou.com.br/api/';
    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IlVzdcOhcmlvIHBhZHLDo28iLCJVc2VySWQiOiIxIiwiRW1wcmVzYUlkIjoiMSIsIm5iZiI6MTc0NjIwNTk0NywiZXhwIjoxNzQ2MjkyMzQ3LCJpYXQiOjE3NDYyMDU5NDd9.fmhSqDwcJP7g3ecqKe90J2RWcxIsaOj1fJSR8WDXxfA';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(endpoint, queryParameters: params);

      return response.data;
    } on DioException catch (e) {
      print(['Error aqui', e.error]);
      throw ServerException(message: 'Erro de servidor');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      if (data is FormData) {
        dio.options.headers.addAll({"Content-Type": "multipart/form-data"});
      } else {
        dio.options.headers.remove("Content-Type");
      }

      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      print(e.response);
      throw ServerException(
        message:
            e.response?.data['message'] ??
            e.response?.data['error'] ??
            'Erro de servidor',
      );
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      if (data is FormData) {
        dio.options.headers.addAll({"Content-Type": "multipart/form-data"});
      } else {
        dio.options.headers.remove("Content-Type");
      }

      final response = await dio.put(
        endpoint,
        data: data,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Erro de servidor',
      );
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      if (data is FormData) {
        dio.options.headers.addAll({"Content-Type": "multipart/form-data"});
      } else {
        dio.options.headers.remove("Content-Type");
      }

      final response = await dio.patch(
        endpoint,
        data: data,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      throw ServerException(
        message: e.response?.data['message'] ?? 'Erro de servidor',
      );
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.delete(endpoint, queryParameters: params);

      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Erro de servidor',
      );
    }
  }
}
