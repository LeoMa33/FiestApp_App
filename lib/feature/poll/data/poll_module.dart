import 'package:dio/dio.dart';

class PollModule {
  final Dio _dio;
  final String baseRoute = '/poll';

  PollModule(this._dio);

  Future<Response> getById(String id) async {
    return await _dio.get('$baseRoute/$id');
  }

  Future<Response> delete(String id) async {
    return await _dio.delete('$baseRoute/$id');
  }

  Future<Response> get() async {
    return await _dio.get(baseRoute);
  }

  Future<Response> add(dynamic data) async {
    return await _dio.post(baseRoute, data: data);
  }

  Future<Response> vote(dynamic data) async {
    return await _dio.post('$baseRoute/votes', data: data);
  }
}
