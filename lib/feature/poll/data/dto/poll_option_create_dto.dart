class PollOptionCreateDto {
  final String value;

  PollOptionCreateDto({required this.value});

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  factory PollOptionCreateDto.fromJson(Map<String, dynamic> json) {
    return PollOptionCreateDto(value: json['value'] as String);
  }
}
