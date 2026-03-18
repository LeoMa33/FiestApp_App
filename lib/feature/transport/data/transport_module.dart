import 'package:dio/dio.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_create_dto.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_dto.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_update_dto.dart';

class TransportModule {
  final Dio _dio;
  final String baseRoute = '/transport';

  TransportModule(this._dio);

  Future<List<TransportDto>> getAll() async {
    final response = await _dio.get(baseRoute);
    final List<dynamic> data = response.data;
    return data.map((json) => TransportDto.fromJson(json)).toList();
  }

  Future<TransportDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return TransportDto.fromJson(response.data);
  }

  Future<TransportDto> add(TransportCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return TransportDto.fromJson(response.data);
  }

  Future<TransportDto> patch(String id, TransportUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return TransportDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }

  Future<TransportDto> join(String id) async {
    final response = await _dio.post('$baseRoute/join/$id');
    return TransportDto.fromJson(response.data);
  }

  Future<TransportDto> leave(String id) async {
    final response = await _dio.post('$baseRoute/leave/$id');
    return TransportDto.fromJson(response.data);
  }
}
