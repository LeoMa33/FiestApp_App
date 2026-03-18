import 'package:dio/dio.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_create_dto.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_dto.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_update_dto.dart';

class AccomodationModule {
  final Dio _dio;
  final String baseRoute = '/accommodation';

  AccomodationModule(this._dio);

  Future<List<AccommodationDto>> getAll() async {
    final response = await _dio.get(baseRoute);
    final List<dynamic> data = response.data;
    return data.map((json) => AccommodationDto.fromJson(json)).toList();
  }

  Future<AccommodationDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return AccommodationDto.fromJson(response.data);
  }

  Future<AccommodationDto> post(AccommodationCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return AccommodationDto.fromJson(response.data);
  }

  Future<AccommodationDto> patch(String id, AccommodationUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return AccommodationDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }

  Future<AccommodationDto> join(String id) async {
    final response = await _dio.post('$baseRoute/join/$id');
    return AccommodationDto.fromJson(response.data);
  }

  Future<AccommodationDto> leave(String id) async {
    final response = await _dio.post('$baseRoute/leave/$id');
    return AccommodationDto.fromJson(response.data);
  }
}
