import 'poll_option_dto.dart';

class PollDto {
  final String id;
  final String question;
  final bool multiChoice;
  final DateTime timerEnd;
  final List<PollOptionDto> options;

  PollDto({
    required this.id,
    required this.question,
    required this.multiChoice,
    required this.timerEnd,
    required this.options,
  });

  factory PollDto.fromJson(Map<String, dynamic> json) {
    print(json);
    return PollDto(
      id: json['id'] as String,
      question: json['question'] as String,
      multiChoice: (json['multiChoice'] == true),
      timerEnd: DateTime.parse(json['timerEnd'] as String),
      options: (json['options'] as List)
          .map((item) => PollOptionDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'multiChoice': multiChoice,
      'timerEnd': timerEnd.toIso8601String(),
      'options': options.map((option) => option.toJson()).toList(),
    };
  }

  Duration get timeLeft => timerEnd.difference(DateTime.now());
  bool get isExpired => DateTime.now().isAfter(timerEnd);
}
