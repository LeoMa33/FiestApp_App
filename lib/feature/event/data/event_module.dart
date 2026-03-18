import 'package:dio/dio.dart';
import 'package:fiestapp/feature/event/data/dto/event_create_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_update_dto.dart';

class EventModule {
  final Dio _dio;
  final String baseRoute = '/event';

  EventModule(this._dio);
  Future<List<EventDto>> getAll() async {
    final response = await _dio.get(baseRoute);
    final List<dynamic> data = response.data;
    return data.map((json) => EventDto.fromJson(json)).toList();
  }

  Future<EventDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return EventDto.fromJson(response.data);
  }

  Future<EventDto> post(EventCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return EventDto.fromJson(response.data);
  }

  Future<EventDto> patch(String id, EventUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return EventDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }
}
