import 'package:dio/dio.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_dto.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_response_dto.dart';

class AuthModule {
  final Dio _dio;

  final baseRoute = '/auth';
  AuthModule(this._dio);

  Future<AuthResponseDto> login(AuthDto data) async {
    final response = await _dio.post('$baseRoute/login', data: data.toJson());
    return AuthResponseDto.fromJson(response.data);
  }

  Future<AuthResponseDto> register(AuthDto data) async {
    final response = await _dio.post(
      '$baseRoute/register',
      data: data.toJson(),
    );
    return AuthResponseDto.fromJson(response.data);
  }

  Future<AuthResponseDto> refresh() async {
    final response = await _dio.post('$baseRoute/refresh');
    return AuthResponseDto.fromJson(response.data);
  }

  Future<void> askResetPassword(String mail) async {
    await _dio.post('$baseRoute/ask-reset-password', data: {'mail': mail});
  }

  Future<void> updatePassword(String key, String password) async {
    await _dio.patch(
      '$baseRoute/update_password',
      data: {'key': key, 'password': password},
    );
  }

  updateCredential(data) async {
    // TODO type
    await _dio.patch('$baseRoute/update_credentials', data: data.toJson());
  }
}
