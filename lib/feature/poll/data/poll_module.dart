import 'package:dio/dio.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_create_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/vote_dto.dart';

class PollModule {
  final Dio _dio;
  final String baseRoute = '/poll';

  PollModule(this._dio);

  Future<PollDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return PollDto.fromJson(response.data);
  }

  Future<PollDto> add(PollCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return PollDto.fromJson(response.data);
  }

  Future<void> vote(VotesDto dto, String pollId) async {
    await _dio.post('$baseRoute/$pollId/votes', data: dto.toJson());
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }
}
