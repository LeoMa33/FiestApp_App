import 'package:dio/dio.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/feature/auth/data/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

final tokenProvider = StateProvider<String?>((ref) => null);
final refreshTokenProvider = StateProvider<String?>((ref) => null);

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(BaseOptions(baseUrl: API_BASE));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = ref.read(tokenProvider);

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        print(error.response);

        print(error.requestOptions.path);
        if (error.response?.statusCode != 401 ||
            error.requestOptions.path.contains('/auth/login') ||
            error.requestOptions.path.contains('/auth/refresh')) {
          return handler.next(error);
        }

        try {
          final storage = FlutterSecureStorage();
          final refreshToken = ref.read(tokenProvider);

          if (refreshToken == null) {
            print('No refresh token');
            return handler.next(error);
          }

          final success = await AuthService.refreshAuthToken(
            storage: storage,
            refreshToken: refreshToken,
          );

          if (success) {
            final newToken = await storage.read(key: 'jwt_token');
            final newRefreshToken = await storage.read(key: 'refresh_token');

            ref.read(tokenProvider.notifier).state = newToken;
            ref.read(tokenProvider.notifier).state = newRefreshToken;

            final options = error.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';

            final response = await dio.fetch(options);

            return handler.resolve(response);
          }
        } catch (e) {
          print('here');
          print(e);

          return handler.next(error);
        }

        return handler.next(error);
      },
    ),
  );

  return dio;
}
