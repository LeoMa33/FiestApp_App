class TransportCreateDto {
  final int count;
  final String eventId;

  TransportCreateDto({required this.count, required this.eventId});

  Map<String, dynamic> toJson() {
    return {'count': count, 'eventId': eventId};
  }

  factory TransportCreateDto.fromJson(Map<String, dynamic> json) {
    return TransportCreateDto(
      count: (json['count'] as num).toInt(),
      eventId: json['eventId'] as String,
    );
  }
}
