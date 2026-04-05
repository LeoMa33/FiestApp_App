import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/invitation/data/dto/invitation_dto.dart';

class InvitationService {
  static Future<InvitationDto> getOrCreate({
    required ApiClient apiClient,
    required String eventId,
  }) async {
    try {
      final invitation = await apiClient.invitation.getByEventId(eventId);

      if (invitation.isExpired) {
        return await apiClient.invitation.post(eventId);
      }

      return invitation;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return await apiClient.invitation.post(eventId);
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
