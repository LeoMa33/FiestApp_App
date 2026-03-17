import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/poll/domain/models/poll-option.dart';

class Poll {
  final String guid;
  final Event event;
  final String question;
  final List<PollOption> pollOptions;
  final int createdAt;

  Poll({
    required this.guid,
    required this.event,
    required this.question,
    required this.pollOptions,
    required this.createdAt,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      guid: json['id'] as String,
      event: Event.fromJson(json['event']),
      question: json['question'] as String,
      pollOptions: (json['poll_options'] as List)
          .map((e) => PollOption.fromJson(e))
          .toList(),
      createdAt: json['creation_date'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': guid,
      'event': event.toJson(),
      'question': question,
      'poll_options': pollOptions.map((e) => e.toJson()).toList(),
      'creation_date': createdAt,
    };
  }
}
