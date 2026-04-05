import 'package:dio/dio.dart';
import 'package:fiestapp/feature/user/data/dto/user_create_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_update_dto.dart';
import 'package:http_parser/http_parser.dart';

class UserModule {
  final Dio _dio;
  final String baseRoute = '/user';

  UserModule(this._dio);

  Future<UserDto> getMe() async {
    final response = await _dio.get('$baseRoute/me');
    return UserDto.fromJson(response.data);
  }

  Future<UserDto> post(UserCreateDto dto) async {
    final Map<String, dynamic> data = dto.toJson();

    print(dto.isEstimationActive);
    
    if (dto.profilePicture != null) {
      data['file'] = await MultipartFile.fromFile(
        dto.profilePicture!.path,
        filename: dto.profilePicture!.path.split('/').last,
        contentType: MediaType('image', 'webp'),
      );
    }

    final formData = FormData.fromMap(data);

    final response = await _dio.post(
      baseRoute,
      data: formData,
    );

    return UserDto.fromJson(response.data);
  }

  Future<UserDto> patch(String id, UserUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return UserDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }
}
