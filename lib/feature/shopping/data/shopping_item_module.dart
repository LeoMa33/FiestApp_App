import 'package:dio/dio.dart';

class ShoppingItemModule {
  final Dio _dio;
  final String baseRoute = '/shopping-item';

  ShoppingItemModule(this._dio);

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
