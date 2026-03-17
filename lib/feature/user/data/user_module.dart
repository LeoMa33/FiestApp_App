import 'package:dio/dio.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';

class UserModule {
  final Dio _dio;
  UserModule(this._dio);

  Future<User> getMe() async {
    try {
      final response = await _dio.get('/users/me');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> updateProfile(Map<String, dynamic> data) async {
    final response = await _dio.patch('/users/update', data: data);
    return User.fromJson(response.data);
  }

  Exception _handleError(DioException e) {
    if (e.response?.statusCode == 404)
      return Exception("Utilisateur non trouvé");
    return Exception("Une erreur réseau est survenue");
  }
}
