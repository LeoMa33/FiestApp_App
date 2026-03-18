class InvitationCreateDto {
  final String eventId;

  InvitationCreateDto({required this.eventId});

  Map<String, dynamic> toJson() {
    return {'eventId': eventId};
  }

  factory InvitationCreateDto.fromJson(Map<String, dynamic> json) {
    return InvitationCreateDto(eventId: json['eventId'] as String);
  }
}
