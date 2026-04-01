class TransportCreateDto {
  final int count;
  final String eventId;
  final String address;

  TransportCreateDto({
    required this.count,
    required this.eventId,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'eventId': eventId,
      'address': address,
    };
  }

  factory TransportCreateDto.fromJson(Map<String, dynamic> json) {
    return TransportCreateDto(
      count: (json['count'] as num).toInt(),
      eventId: json['eventId'] as String,
      address: json['address'] as String,
    );
  }
}
