import 'package:fiestapp/feature/poll/data/dto/poll_option_create_dto.dart';

class PollCreateDto {
  final String question;
  final bool multiChoice;
  final int duration;
  final List<PollOptionCreateDto> options;
  final String eventId;

  PollCreateDto({
    required this.question,
    required this.multiChoice,
    required this.duration,
    required this.options,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'multiChoice': multiChoice,
      'duration': duration,
      'options': options.map((option) => option.toJson()).toList(),
      'eventId': eventId,
    };
  }

  factory PollCreateDto.fromJson(Map<String, dynamic> json) {
    return PollCreateDto(
      question: json['question'] as String,
      multiChoice: json['multiChoice'] as bool,
      duration: (json['duration'] as num).toInt(),
      options: (json['options'] as List)
          .map(
            (item) =>
                PollOptionCreateDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      eventId: json['eventId'] as String,
    );
  }
}
