import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioProvider);

  return ApiClient(dio);
}
