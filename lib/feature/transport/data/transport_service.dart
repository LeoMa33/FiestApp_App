import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_create_dto.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_dto.dart';

class TransportService {
  static Future<TransportDto> create({
    required ApiClient apiClient,
    required TransportCreateDto dto,
  }) async {
    try {
      return await apiClient.transport.add(dto);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<TransportDto> join({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      return await apiClient.transport.join(id);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<TransportDto> leave({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      return await apiClient.transport.leave(id);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
