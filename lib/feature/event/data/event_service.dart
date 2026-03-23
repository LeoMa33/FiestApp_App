import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/event/data/dto/event_create_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_filter_dto.dart';
import 'package:fiestapp/feature/event/data/dto/prunes_dto.dart';

class EventService {
  static Future<List<EventDto>> getAll({
    required ApiClient apiClient,
    required EventFilterDto dto,
  }) async {
    try {
      final response = await apiClient.events.getAll(dto);

      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<EventDto> getById({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      final response = await apiClient.events.getById(id);

      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<PrunesDto> getPrunes({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      final response = await apiClient.events.getPrunes(id);

      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<EventDto> create({
    required ApiClient apiClient,
    required EventCreateDto dto,
  }) async {
    try {
      final response = await apiClient.events.post(dto);

      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
