import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';

class UserDto {
  final String id;
  final String name;
  final String mail;
  final int age;
  final double weight;
  final String? imageUrl;
  final double height;
  final AlcoholConsumption alcoholConsumption;

  UserDto({
    required this.id,
    required this.name,
    required this.mail,
    required this.age,
    required this.weight,
    this.imageUrl,
    required this.height,
    required this.alcoholConsumption,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      name: json['name'] as String,
      mail: json['mail'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      height: (json['height'] as num).toDouble(),
      alcoholConsumption: AlcoholConsumption.values.byName(
        json['alcohol_consumption'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'age': age,
      'weight': weight,
      'imageUrl': imageUrl,
      'height': height,
      'alcohol_consumption': alcoholConsumption.name,
    };
  }
}
