import 'package:image_picker/image_picker.dart';

class EventCreateDto {
  final String name;
  final String? description;
  final DateTime date;
  final String address;
  final XFile? image;

  EventCreateDto({
    required this.name,
    this.description,
    required this.date,
    required this.address,
    this.image,
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
