// lib/src/features/events/data/event_module.dart

import 'package:dio/dio.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';

class EventModule {
  final Dio _dio;

  EventModule(this._dio);

  /// Récupérer tous les événements
  Future<List<Event>> getAll() async {
    try {
      final response = await _dio.get('/events');

      // On transforme la liste JSON en liste d'objets Event
      final List<dynamic> data = response.data;
      return data.map((json) => Event.fromJson(json)).toList();
    } on DioException catch (e) {
      // Ici tu peux gérer des erreurs spécifiques (ex: 404, 500)
      throw Exception(
        "Erreur lors de la récupération des événements: ${e.message}",
      );
    }
  }

  /// Récupérer un événement par son ID
  Future<Event> getById(String id) async {
    final response = await _dio.get('/events/$id');
    return Event.fromJson(response.data);
  }

  /// Créer un événement
  Future<void> create(Event event) async {
    await _dio.post('/events', data: event.toJson());
  }
}
