import 'package:dio/dio.dart';

class ExpenseModule {
  final Dio _dio;
  final String baseRoute = '/expense';

  ExpenseModule(this._dio);

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
}
