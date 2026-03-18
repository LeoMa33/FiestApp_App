import 'package:dio/dio.dart';
import 'package:fiestapp/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

final tokenProvider = StateProvider<String?>((ref) => null);

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(BaseOptions(baseUrl: API_BASE));

  final token = ref.watch(tokenProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
}
