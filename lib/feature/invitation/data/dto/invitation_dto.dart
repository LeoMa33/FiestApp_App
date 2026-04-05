class InvitationDto {
  final String id;
  final DateTime expireAt;
  final String eventId;

  InvitationDto({
    required this.id,
    required this.expireAt,
    required this.eventId,
  });

  factory InvitationDto.fromJson(Map<String, dynamic> json) {
    return InvitationDto(
      id: json['id'] as String,
      expireAt: DateTime.parse(json['expireAt'] as String),
      eventId: json['eventId'] as String,
    );
  }

  bool get isExpired => DateTime.now().isAfter(expireAt);
}
