import 'package:dio/dio.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/invitation/data/dto/invitation_dto.dart';

class InvitationModule {
  final Dio _dio;
  final String baseRoute = '/invitation';

  InvitationModule(this._dio);

  Future<InvitationDto> getByEventId(String eventId) async {
    final response = await _dio.get(
      baseRoute,
      queryParameters: {'eventId': eventId},
    );
    return InvitationDto.fromJson(response.data);
  }

  Future<InvitationDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return InvitationDto.fromJson(response.data);
  }

  Future<InvitationDto> post(String eventId) async {
    final response = await _dio.post(baseRoute, data: {'eventId': eventId});
    return InvitationDto.fromJson(response.data);
  }

  Future<EventDto> accept(String id) async {
    final response = await _dio.get('$baseRoute/$id/accept');
    return EventDto.fromJson(response.data);
  }
}
