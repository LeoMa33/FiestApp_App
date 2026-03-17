import 'package:dio/dio.dart';
import 'package:fiestapp/feature/event/data/event_module.dart';
import 'package:fiestapp/feature/user/data/user_module.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  EventModule? _events;
  EventModule get events => _events ??= EventModule(dio);

  UserModule? _users;
  UserModule get users => _users ??= UserModule(dio);
}
