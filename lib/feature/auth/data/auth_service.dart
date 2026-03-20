import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static Future<String> login({
    required ApiClient apiClient,
    required FlutterSecureStorage storage,
    required AuthDto dto,
  }) async {
    try {
      final response = await apiClient.auth.login(dto);
      await storage.write(key: 'jwt_token', value: response.token);
      await storage.write(key: 'refresh_token', value: response.refreshToken);

      return response.token;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<String> register({
    required ApiClient apiClient,
    required FlutterSecureStorage storage,
    required AuthDto dto,
  }) async {
    try {
      final response = await apiClient.auth.register(dto);
      await storage.write(key: 'jwt_token', value: response.token);
      await storage.write(key: 'refresh_token', value: response.refreshToken);

      return response.token;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static getMe({
    required ApiClient apiClient,
    required FlutterSecureStorage storage,
  }) async {
    try {
      await apiClient.users.getMe();
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
