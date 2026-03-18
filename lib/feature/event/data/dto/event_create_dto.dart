class EventCreateDto {
  final String name;
  final String? description;
  final DateTime date;
  final String address;

  EventCreateDto({
    required this.name,
    this.description,
    required this.date,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'address': address,
    };
  }
}
