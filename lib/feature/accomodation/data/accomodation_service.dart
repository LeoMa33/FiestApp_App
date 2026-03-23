import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_create_dto.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_dto.dart';

class AccomodationService {
  static Future<AccommodationDto> create({
    required ApiClient apiClient,
    required AccommodationCreateDto dto,
  }) async {
    try {
      return await apiClient.accommodation.post(dto);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<AccommodationDto> join({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      return await apiClient.accommodation.join(id);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<AccommodationDto> leave({
    required ApiClient apiClient,
    required String id,
  }) async {
    try {
      return await apiClient.accommodation.leave(id);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
