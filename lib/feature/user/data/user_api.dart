import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  static final String baseUrl = dotenv.env['API_ENDPOINT'] ?? '';

  static Future<bool> checkFingerprintAccount() async {
    // Mocking the response to true for development
    await Future.delayed(const Duration(milliseconds: 500));
    return true;

    /*
    final String deviceFingerprint = await _getDeviceFingerprint();
    final response = await http.post(
      Uri.parse('$baseUrl/auth/device'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'deviceId': deviceFingerprint}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['accessToken'] == true;
    } else {
      return false;
    }
    */
  }

  static Future<Map<String, dynamic>> register(
    User user,
    File? imageFile,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Return a mock response object
    return {
      'status': 201,
      'data': {'id': 'mock-id-123', 'username': user.username},
    };
  }

  static Future<String> _getDeviceFingerprint() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.fingerprint;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_id';
    } else {
      return 'unsupported_platform';
    }
  }
}
