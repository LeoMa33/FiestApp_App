import 'package:fiestapp/constant.dart';

class S3Service {
  static String getUserImage(String? imageUrl) {
    return _getImageUrl(imageUrl, AppImage.defaultProfilImage);
  }

  static String getEventImage(String? imageUrl) {
    return _getImageUrl(imageUrl, AppImage.defaultEventImage);
  }

  static String _getImageUrl(String? imageUrl, String defaultImage) {
    if (imageUrl != null) {
      return imageUrl;
    }

    return defaultImage;
  }
}
