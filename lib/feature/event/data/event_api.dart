import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant/constant.dart';

class EventService {
  final eventApi = apiClient.getEventsApi();

  /// Récupère tous les événements
  Future<List<Event>> getEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final String monId = prefs.getString('currentId') ?? '';
    final response = await eventApi.eventControllerFindAll();
    final myEvents = response.data
        ?.toList()
        .where((e) => e.participants.any((p) => p.guid == monId))
        .toList();
    if (response.statusCode == 200) {
      print('✅ Événements récupérés');
      return myEvents ?? [];
    } else {
      print('❌ Erreur récupération événements : ${response.statusCode}');
      return [];
    }
  }

  /// Récupère les événements dont `guid` est l'organisateur
  Future<List<Event>> getMyEvents(String guid) async {
    final prefs = await SharedPreferences.getInstance();
    final String monId = prefs.getString('currentId') ?? '';
    final response = await eventApi.eventControllerFindAll();
    final myEvents = response.data
        ?.toList()
        .where((e) => e.organizer.guid == guid)
        .toList();
    if (response.statusCode == 200) {
      print('✅ Événements récupérés');
      return myEvents ?? [];
    } else {
      print('❌ Erreur récupération événements : ${response.statusCode}');
      return [];
    }
  }

  /// Récupère un événement spécifique par son ID
  Future<Event?> getEventById(String guid) async {
    final response = await eventApi.eventControllerFindOne(id: guid);

    if (response.statusCode == 200) {
      print('✅ Événement récupéré');
      return response.data;
    } else {
      print('❌ Erreur récupération événement : ${response.statusCode}');
      throw Exception('Erreur récupération événement');
    }
  }

  /// Crée un nouvel événement (optionnellement avec image)
  Future<Response<Event>> createEvent(
    CreateEventDto event,
    String guid,
    File? imageFile,
  ) async {
    final createDto = CreateEventDto(
      (b) => b
        ..title = event.title
        ..location = event.location
        ..latitude = event.latitude
        ..longitude = event.longitude
        ..date = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
        ..organizer = guid,
    );

    final response = await eventApi.eventControllerCreate(
      createEventDto: createDto,
    );

    return response;
  }
}
