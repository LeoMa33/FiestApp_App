import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_create_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/vote_dto.dart';

class PollService {
  static Future<PollDto> create({
    required ApiClient apiClient,
    required PollCreateDto dto,
  }) async {
    try {
      return await apiClient.poll.add(dto);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> vote({
    required ApiClient apiClient,
    required VotesDto dto,
    required String pollId,
  }) async {
    try {
      await apiClient.poll.vote(dto, pollId);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
