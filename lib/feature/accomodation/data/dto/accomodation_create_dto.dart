class AccommodationCreateDto {
  final int count;
  final String eventId;

  AccommodationCreateDto({
    required this.count,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'eventId': eventId,
    };
  }
}
