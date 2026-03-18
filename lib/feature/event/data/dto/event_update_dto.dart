class EventUpdateDto {
  final String? name;
  final String? description;
  final DateTime? date;
  final String? address;

  EventUpdateDto({this.name, this.description, this.date, this.address});

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (date != null) 'date': date!.toIso8601String(),
      if (address != null) 'address': address,
    };
  }

  factory EventUpdateDto.fromJson(Map<String, dynamic> json) {
    return EventUpdateDto(
      name: json['name'] as String?,
      description: json['description'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      address: json['address'] as String?,
    );
  }
}
