import 'package:fiestapp/core/utils/date_utils.dart';

import '../../../expense/domain/models/expense.dart';
import '../../../user/domain/models/user.dart';

class Event {
  final String guid;
  final String title;
  final String description;
  final String location;
  final double latitute;
  final double longitude;
  final int date;

  String get formattedDate => formatDate(date);
  final User organizer;
  final List<User> participants;
  final List<Expense> expenses;

  Event({
    required this.guid,
    required this.title,
    required this.description,
    required this.location,
    required this.latitute,
    required this.longitude,
    required this.date,
    required this.organizer,
    required this.participants,
    required this.expenses,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      guid: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      latitute: json['latitude'] as double,
      longitude: json['longitude'] as double,
      date: json['date'] as int,
      organizer: User.fromJson(json['organizer']),
      participants: (json['paticipants'] as List)
          .map((e) => User.fromJson(e))
          .toList(),
      expenses: (json['expenses'] as List)
          .map((e) => Expense.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': guid,
      'title': title,
      'description': description,
      'location': location,
      'latitude': latitute,
      'longitude': longitude,
      'date': date,
      'organizer': organizer.toJson(),
      'paticipants': participants.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
    };
  }
}
