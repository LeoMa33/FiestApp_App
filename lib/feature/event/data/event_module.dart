import 'package:dio/dio.dart';
import 'package:fiestapp/feature/event/data/dto/event_create_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_filter_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_update_dto.dart';
import 'package:fiestapp/feature/event/data/dto/parking_dto.dart';
import 'package:fiestapp/feature/event/data/dto/prunes_dto.dart';
import 'package:http_parser/http_parser.dart';

class EventModule {
  final Dio _dio;
  final String baseRoute = '/event';

  EventModule(this._dio);
  Future<List<EventDto>> getAll(EventFilterDto dto) async {
    final response = await _dio.get(baseRoute, queryParameters: dto.toJson());
    final List<dynamic> items = response.data['items'];

    print(response.data);

    return items.map((json) => EventDto.fromJson(json)).toList();
  }

  Future<EventDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return EventDto.fromJson(response.data);
  }

  Future<PrunesDto> getPrunes(String id) async {
    final response = await _dio.get('$baseRoute/$id/prunes');
    return PrunesDto.fromJson(response.data);
  }

  Future<List<ParkingDto>> getParkings(String id) async {
    final response = await _dio.get('$baseRoute/$id/parkings');
    final List<dynamic> data = response.data;
    return data.map((json) => ParkingDto.fromJson(json)).toList();
  }

  Future<EventDto> post(EventCreateDto dto) async {
    dynamic data;

    if (dto.image != null) {
      data = FormData.fromMap({
        ...dto.toJson(),
        'file': await MultipartFile.fromFile(
          dto.image!.path,
          filename: dto.image!.path.split('/').last,
          contentType: MediaType('image', 'webp'),
        ),
      });
    } else {
      data = dto.toJson();
    }

    final response = await _dio.post(baseRoute, data: data);

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
