class AccommodationCreateDto {
  final int count;
  final String? address; // Nullable car optionnel dans ton Swagger
  final String eventId;

  AccommodationCreateDto({
    required this.count,
    this.address,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'address': address,
      'eventId': eventId, // On respecte la clé exacte attendue par NestJS
    };
  }
}
