import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/user/data/dto/user_create_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_dto.dart';

class UserService {
  static Future<UserDto> create({
    required ApiClient apiClient,
    required UserCreateDto dto,
  }) async {
    try {
      final response = await apiClient.users.post(dto);

      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
