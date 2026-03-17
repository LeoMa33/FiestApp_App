import 'package:dio/dio.dart';

class UserModule {
  final Dio _dio;
  final String baseRoute = '/user';

  UserModule(this._dio);

  Future<Response> getMe() async {
    return await _dio.get('$baseRoute/me');
  }

  Future<Response> post(dynamic data) async {
    return await _dio.post(baseRoute, data: data);
  }

  Future<Response> patch(String id, dynamic data) async {
    return await _dio.patch('$baseRoute/$id', data: data);
  }

  Future<Response> delete(String id) async {
    return await _dio.delete('$baseRoute/$id');
  }
}
