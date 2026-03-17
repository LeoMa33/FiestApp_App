import 'package:dio/dio.dart';

class AccomodationModule {
  final Dio _dio;
  final String baseRoute = '/accommodation';

  AccomodationModule(this._dio);

  Future<Response> getById(String id) async {
    return await _dio.get('$baseRoute/$id');
  }

  Future<Response> patch(String id, dynamic data) async {
    return await _dio.patch('$baseRoute/$id', data: data);
  }

  Future<Response> delete(String id) async {
    return await _dio.delete('$baseRoute/$id');
  }

  Future<Response> get() async {
    return await _dio.get(baseRoute);
  }

  Future<Response> post(dynamic data) async {
    return await _dio.post(baseRoute, data: data);
  }

  Future<Response> join(String id) async {
    return await _dio.post('$baseRoute/join/$id');
  }

  Future<Response> leave(String id) async {
    return await _dio.post('$baseRoute/leave/$id');
  }
}
