import 'package:dio/dio.dart';
import 'package:fiestapp/feature/accomodation/data/accomodation_module.dart';
import 'package:fiestapp/feature/auth/data/aut_module.dart';
import 'package:fiestapp/feature/event/data/event_module.dart';
import 'package:fiestapp/feature/expense/data/expense_module.dart';
import 'package:fiestapp/feature/poll/data/poll_module.dart';
import 'package:fiestapp/feature/shopping/data/shopping_item_module.dart';
import 'package:fiestapp/feature/transport/data/transport_module.dart';
import 'package:fiestapp/feature/user/data/user_module.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  EventModule? _events;
  EventModule get events => _events ??= EventModule(dio);

  UserModule? _users;
  UserModule get users => _users ??= UserModule(dio);

  AuthModule? _auth;
  AuthModule get auth => _auth ??= AuthModule(dio);

  TransportModule? _transport;
  TransportModule get transport => _transport ??= TransportModule(dio);

  AccomodationModule? _accommodation;
  AccomodationModule get accommodation =>
      _accommodation ??= AccomodationModule(dio);

  ExpenseModule? _expense;
  ExpenseModule get expense => _expense ??= ExpenseModule(dio);

  PollModule? _poll;
  PollModule get poll => _poll ??= PollModule(dio);

  ShoppingItemModule? _shoppingItem;
  ShoppingItemModule get shoppingItem =>
      _shoppingItem ??= ShoppingItemModule(dio);
}
