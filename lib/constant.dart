import 'package:flutter_dotenv/flutter_dotenv.dart';

final String defaultEventImage = "${S3_enpoint}event/event.webp";
final String S3_enpoint = dotenv.env['S3_ENDPOINT'] ?? '';
final String API_BASE = dotenv.env['API_BASE'] ?? '';

class AppImage {
  static String defaultProfilImage = '${S3_enpoint}user/user.webp';
  static String homeHeader =
      'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  static String defaultEventImage =
      'https://tripxl.com/blog/wp-content/uploads/2024/09/Subsix-Underwater-Nightclub-Niyama-Private-Islands.jpg';
}
