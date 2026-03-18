import 'package:dio/dio.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_dto.dart';

class AuthModule {
  final Dio _dio;

  final baseRoute = '/auth';
  AuthModule(this._dio);

  login(AuthDto data) async {
    await _dio.post('$baseRoute/login', data: data.toJson());
  }

  register(AuthDto data) async {
    await _dio.post('$baseRoute/register', data: data.toJson());
  }

  refresh() async {
    await _dio.post('$baseRoute/refresh');
  }

  updateCredential(data) async {
    // TODO type
    await _dio.patch('$baseRoute/update_credentials', data: data.toJson());
  }
}
