import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/user/data/dto/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashService {
  static Future<({AppRoute route, UserDto? user})> checkInitialAuth({
    required ApiClient apiClient,
    required FlutterSecureStorage storage,
  }) async {
    try {
      final token = await storage.read(key: 'jwt_token');

      if (token == null || token.isEmpty) {
        return (route: AppRoute.login, user: null);
      }

      final user = await apiClient.users.getMe();

      return (route: AppRoute.home, user: user);
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return (route: AppRoute.createprofile, user: null);
      }
      return (route: AppRoute.login, user: null);
    } catch (e) {
      print(e);
      return (route: AppRoute.login, user: null);
    }
  }
}
